import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../config/routes.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = score / totalQuestions;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 20.0,
                percent: percent,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Score',
                      style: textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    Text(
                      '$score/$totalQuestions',
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                progressColor: colorScheme.primary,
                backgroundColor: colorScheme.primary.withAlpha(30),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 32),
              Text(
                'Congratulation',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Great job, Rafi Fauzan! You Did It',
                style: textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _buildButton(
                context,
                text: 'Share',
                onPressed: () {
                  // Gatau gimana cara sharenya, ntar lah ini ya
                },
                isPrimary: false,
              ),
              const SizedBox(height: 16),
              _buildButton(
                context,
                text: 'Back to Home',
                onPressed: () {
                  context.go(AppRoutes.home);
                },
                isPrimary: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, {
        required String text,
        required VoidCallback onPressed,
        required bool isPrimary,
      }) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? colorScheme.primary : Colors.white,
          foregroundColor: isPrimary ? Colors.white : colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary ? BorderSide.none : BorderSide(color: colorScheme.primary),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}