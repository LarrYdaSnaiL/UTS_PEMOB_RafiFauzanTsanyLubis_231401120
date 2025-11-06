import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/dummy_data.dart';
import '../models/quiz_models.dart';
import '../services/history_service.dart';
import '../widgets/activity_card.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HistoryService _historyService = HistoryService();
  Map<String, String> _quizHistory = {};

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await _historyService.getAllQuizResults();
    setState(() {
      _quizHistory = history;
    });
  }

  void _onNavigateToQuiz(QuizCategory category) async {
    await context.pushNamed(
      'quiz',
      pathParameters: {'categoryId': category.id},
    );
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _buildHeader(textTheme),
            const SizedBox(height: 20),
            _buildBanner(context),
            const SizedBox(height: 20),
            _buildSearch(),
            const SizedBox(height: 20),
            _buildCategories(textTheme),
            const SizedBox(height: 30),
            _buildRecentActivity(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/images/picture.jpg'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rafi Fauzan',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '231401120',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        const Spacer(),
        Chip(
          label: Text(
            '160',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          avatar: Icon(
            Icons.diamond,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        ),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Test Your Knowledge with Quizzes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You're just looking for a playful way to learn something new, quizzes are designed to entertain and educate.",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (DummyData.categories.isNotEmpty) {
                _onNavigateToQuiz(DummyData.categories.first);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Play Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_list, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategories(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: DummyData.categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = DummyData.categories[index];
              return CategoryCard(
                category: category,
                onTap: () => _onNavigateToQuiz(category),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(TextTheme textTheme) {
    final recentCategories = DummyData.categories
        .where((cat) => _quizHistory.containsKey(cat.id))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (recentCategories.isEmpty)
          const Center(child: Text('No recent activity yet. Go play a quiz!'))
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentCategories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final category = recentCategories[index];
              final scoreString = _quizHistory[category.id] ?? '0/0';
              return RecentActivityCard(
                category: category,
                scoreString: scoreString,
                onTap: () => _onNavigateToQuiz(category),
              );
            },
          ),
      ],
    );
  }
}
