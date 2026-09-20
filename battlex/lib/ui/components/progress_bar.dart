import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GlowProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String labelLeft;
  final String labelRight;

  const GlowProgressBar({
    super.key,
    required this.progress,
    required this.labelLeft,
    required this.labelRight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelLeft,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              labelRight,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGlow.withOpacity(0.7),
                      blurRadius: 8,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
