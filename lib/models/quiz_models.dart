import 'dart:ui';

class Question {
  final String id;
  final String text;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizCategory {
  final String id;
  final String name;
  final String iconPath;
  final Color color;
  final List<Question> questions;

  QuizCategory({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
    required this.questions,
  });

  int get totalQuestions => questions.length;
}
