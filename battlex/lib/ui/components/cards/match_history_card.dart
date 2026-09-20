import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../glass_container.dart';

class MatchHistoryCard extends StatelessWidget {
  final String title;
  final String gameMode;
  final String date;
  final String status;
  final int? rank;
  final int? kills;
  final String? winnings;
  final VoidCallback onTap;

  const MatchHistoryCard({
    super.key,
    required this.title,
    required this.gameMode,
    required this.date,
    required this.status,
    this.rank,
    this.kills,
    this.winnings,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWin = rank == 1 || (winnings != null && winnings != '₹0');
    final bool isLive = status == 'LIVE';
    final bool isUpcoming = status == 'UPCOMING';

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Strip
            Container(
              height: 4,
              color: isLive 
                  ? AppColors.error 
                  : isWin 
                      ? AppColors.successGreen 
                      : isUpcoming 
                          ? AppColors.primaryContainer 
                          : AppColors.surfaceContainerHighest,
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isLive 
                              ? AppColors.errorContainer.withValues(alpha: 0.2) 
                              : AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(4),
                          border: isLive ? Border.all(color: AppColors.error) : null,
                        ),
                        child: Text(
                          status,
                          style: AppTextStyles.labelSm.copyWith(
                            color: isLive ? AppColors.error : AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(gameMode, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
                      const SizedBox(width: 8),
                      Text('•', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
                      const SizedBox(width: 8),
                      Text(date, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Results Row
                  if (!isUpcoming && !isLive)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatBox('RANK', '#${rank ?? '-'}', isWin ? AppColors.successGreen : AppColors.onSurface),
                        _buildStatBox('KILLS', '${kills ?? 0}', AppColors.onSurface),
                        _buildStatBox('WON', winnings ?? '₹0', isWin ? AppColors.primaryContainer : AppColors.onSurface),
                      ],
                    ),

                  if (isUpcoming || isLive)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isLive ? Icons.play_arrow : Icons.timer, 
                            color: isLive ? AppColors.error : AppColors.primaryContainer,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isLive ? 'MATCH IS LIVE - ENTER ROOM' : 'STARTS IN 02:45:10',
                            style: AppTextStyles.labelMd.copyWith(
                              color: isLive ? AppColors.error : AppColors.primaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.titleMd.copyWith(color: valueColor)),
      ],
    );
  }
}

