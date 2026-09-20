import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../glass_container.dart';
import '../progress_bar.dart';
import '../badges/live_badge.dart';

class TournamentCard extends StatelessWidget {
  final String title;
  final String gameMode;
  final String prizePool;
  final String entryFee;
  final String matchType;
  final double capacityProgress;
  final String filledLabel;
  final String leftLabel;
  final bool isLive;
  final VoidCallback onTap;

  const TournamentCard({
    super.key,
    required this.title,
    required this.gameMode,
    required this.prizePool,
    required this.entryFee,
    required this.matchType,
    required this.capacityProgress,
    required this.filledLabel,
    required this.leftLabel,
    this.isLive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(0), // Custom padding inside
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Accent Line
            Container(height: 2, color: AppColors.primaryContainer),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tags Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(gameMode, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(matchType, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                          ),
                        ],
                      ),
                      if (isLive) const LiveBadge(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Title
                  Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                  const SizedBox(height: 16),
                  
                  // Stats Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem('PRIZE POOL', prizePool, AppColors.primaryContainer),
                      ),
                      Container(width: 1, height: 32, color: AppColors.surfaceContainerHigh),
                      Expanded(
                        child: _buildStatItem('ENTRY', entryFee, AppColors.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Progress
                  GlowProgressBar(
                    progress: capacityProgress,
                    labelLeft: filledLabel,
                    labelRight: leftLabel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.titleMd.copyWith(color: valueColor)),
      ],
    );
  }
}

