import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/quiz_models.dart';

class CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SvgPicture.asset(
              category.iconPath,
              placeholderBuilder: (context) => Icon(
                Icons.question_mark,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
