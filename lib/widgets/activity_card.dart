import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/quiz_models.dart';

class RecentActivityCard extends StatelessWidget {
  final QuizCategory category;
  final String scoreString;
  final VoidCallback onTap;

  const RecentActivityCard({
    super.key,
    required this.category,
    required this.scoreString,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final parts = scoreString.split('/');
    final int score = int.tryParse(parts[0]) ?? 0;
    final int total = int.tryParse(parts[1]) ?? 1;
    final double percent = total > 0 ? score / total : 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                category.iconPath,
                placeholderBuilder: (context) => Icon(
                  Icons.question_mark,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${category.totalQuestions} Question${category.totalQuestions > 1 ? 's' : ''}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            CircularPercentIndicator(
              radius: 28.0,
              lineWidth: 7.0,
              percent: percent,
              center: Text(
                '${(percent * 100).toInt()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              progressColor: _getScoreColor(percent),
              backgroundColor: _getScoreColor(percent).withAlpha(30),
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double percent) {
    if (percent < 0.3) return Colors.red;
    if (percent < 0.7) return Colors.orange;
    return Colors.green;
  }
}
