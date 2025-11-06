import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/dummy_data.dart';
import '../models/quiz_models.dart';
import '../services/history_service.dart';

class QuestionScreen extends StatefulWidget {
  final String categoryId;

  const QuestionScreen({super.key, required this.categoryId});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late QuizCategory _category;

  int _currentQuestionIndex = 0;
  String? _selectedOption;
  final Map<int, String> _userAnswers = {};
  final HistoryService _historyService = HistoryService();

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
      _userAnswers[_currentQuestionIndex] = option;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _category.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = _userAnswers[_currentQuestionIndex];
      });
    } else {
      _seeResults();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedOption = _userAnswers[_currentQuestionIndex];
      });
    }
  }

  void _seeResults() async {
    int score = 0;
    _userAnswers.forEach((index, answer) {
      if (_category.questions[index].correctAnswer == answer) {
        score++;
      }
    });

    await _historyService.saveQuizResult(
      _category.id,
      score,
      _category.totalQuestions,
    );

    context.goNamed(
      'score',
      queryParameters: {
        'score': '$score',
        'total': '${_category.totalQuestions}',
      },
    );
  }

  void _quitQuiz() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Quiz?'),
        content: const Text(
          'Are you sure you want to quit? Your progress will not be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: const Text('Quit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _category = DummyData.getCategoryById(widget.categoryId);
    _selectedOption = _userAnswers[_currentQuestionIndex];
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = _category.questions[_currentQuestionIndex];
    final bool isLastQuestion =
        _currentQuestionIndex == _category.questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(_category.name),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Text(
            '${_category.totalQuestions} Question${_category.totalQuestions > 1 ? 's' : ''}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question: ${_currentQuestionIndex + 1}/${_category.totalQuestions}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextButton(
                          onPressed: _quitQuiz,
                          child: const Text(
                            'Quit',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentQuestion.text,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...currentQuestion.options.map((option) {
                      return _buildOption(context, option);
                    }).toList(),
                    const Spacer(),
                    if (isLastQuestion)
                      Center(
                        child: TextButton(
                          onPressed: _seeResults,
                          child: Text(
                            'See Result',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildNavigationButtons(isLastQuestion),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String option) {
    final bool isSelected = _selectedOption == option;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _onOptionSelected(option),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            option,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(bool isLastQuestion) {
    return Row(
      children: [
        if (_currentQuestionIndex > 0)
          Expanded(
            child: ElevatedButton(
              onPressed: _previousQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Previous'),
            ),
          ),
        if (_currentQuestionIndex > 0) const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(isLastQuestion ? 'Finish' : 'Next'),
          ),
        ),
      ],
    );
  }
}
