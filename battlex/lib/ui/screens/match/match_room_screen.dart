import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'join_confirmation_sheet.dart';

class MatchRoomScreen extends StatelessWidget {
  final String matchId;

  const MatchRoomScreen({super.key, required this.matchId});

  void _showJoinModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const JoinConfirmationSheet(entryFee: 50, balance: 2450),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(showBackButton: true, title: 'Match Details'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Banner Header
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      image: DecorationImage(
                        image: NetworkImage('https://placeholder.com/800x400'), // Replace
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(4)),
                              child: Text('SQUAD', style: AppTextStyles.labelSm.copyWith(color: AppColors.onPrimaryContainer)),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.surfaceBright, borderRadius: BorderRadius.circular(4)),
                              child: Text('ERANGEL', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('BGMI Erangel Classic Squad', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface)),
                      ],
                    ),
                  ),

                  // Info Grid
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatColumn('PRIZE POOL', '₹2,500', AppColors.primaryContainer),
                          Container(width: 1, height: 40, color: AppColors.surfaceContainerHigh),
                          _buildStatColumn('PER KILL', '₹10', AppColors.onSurface),
                          Container(width: 1, height: 40, color: AppColors.surfaceContainerHigh),
                          _buildStatColumn('ENTRY FEE', '₹50', AppColors.onSurface),
                        ],
                      ),
                    ),
                  ),

                  // Time & Room Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('MATCH SCHEDULE', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month, color: AppColors.primaryContainer, size: 20),
                            const SizedBox(width: 8),
                            Text('24 Oct 2026 • 09:00 PM', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        Text('ROOM CREDENTIALS', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                        const SizedBox(height: 8),
                        GlassContainer(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(Icons.lock_outline, color: AppColors.secondary, size: 32),
                              const SizedBox(height: 12),
                              Text('Room ID and Password will be revealed here 15 minutes before the match starts.', 
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text('PRIZE BREAKDOWN', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                        const SizedBox(height: 8),
                        _buildPrizeRow('Rank 1 (Winner)', '₹1,000', true),
                        _buildPrizeRow('Rank 2 (Runner Up)', '₹500', false),
                        _buildPrizeRow('Rank 3', '₹250', false),
                        _buildPrizeRow('Rank 4-10', '₹50', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Fixed Bottom Bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border(top: BorderSide(color: AppColors.surfaceContainerHigh)),
            ),
            child: PrimaryButton(
              text: 'JOIN MATCH NOW • ₹50',
              onPressed: () => _showJoinModal(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.titleMd.copyWith(color: color)),
      ],
    );
  }

  Widget _buildPrizeRow(String rank, String amount, bool isFirst) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isFirst ? AppColors.primaryContainer.withOpacity(0.1) : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
        border: isFirst ? Border.all(color: AppColors.primaryContainer.withOpacity(0.3)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rank, style: AppTextStyles.bodyMd.copyWith(color: isFirst ? AppColors.primaryContainer : AppColors.onSurface)),
          Text(amount, style: AppTextStyles.titleMd.copyWith(color: isFirst ? AppColors.primaryContainer : AppColors.onSurface)),
        ],
      ),
    );
  }
}
