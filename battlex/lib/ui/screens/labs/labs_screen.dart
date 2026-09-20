import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../components/glass_container.dart';

class LabsScreen extends StatelessWidget {
  const LabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'BattleX Labs', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('EXPERIMENTAL FEATURES', style: AppTextStyles.labelSm.copyWith(color: AppColors.primaryContainer)),
            const SizedBox(height: 8),
            Text('Sneak peek into what we are building next.', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
            const SizedBox(height: 32),
            
            _buildLabFeature(
              'Clans & Guilds',
              'Create a clan, invite friends, and compete in Guild Wars for massive prize pools.',
              Icons.shield,
              'COMING IN V1.2',
            ),
            const SizedBox(height: 24),
            _buildLabFeature(
              'Live Streaming Integration',
              'Stream your matches directly to YouTube/Twitch from within the BattleX app.',
              Icons.live_tv,
              'IN DEVELOPMENT',
            ),
            const SizedBox(height: 24),
            _buildLabFeature(
              '1v1 Wager Matches',
              'Challenge a specific player to a custom 1v1 match for an agreed amount.',
              Icons.sports_kabaddi,
              'PROTOTYPE',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabFeature(String title, String description, IconData icon, String status) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.onSurface, size: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(status, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
          const SizedBox(height: 8),
          Text(description, style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
        ],
      ),
    );
  }
}

