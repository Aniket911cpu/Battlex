import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Refer & Earn', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Graphic
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://placeholder.com/600x300'), // Replace with actual art
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('EARN ₹100', style: AppTextStyles.displayLg.copyWith(color: AppColors.primaryContainer)),
                    Text('FOR EVERY FRIEND', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface, letterSpacing: 2)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            Text('YOUR REFERRAL CODE', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
            const SizedBox(height: 12),
            GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BX-SHADOW-99', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface, letterSpacing: 2)),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppColors.primaryContainer),
                    onPressed: () {
                      // Copy to clipboard
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Steps
            Text('HOW IT WORKS', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
            const SizedBox(height: 16),
            _buildStep(1, 'Share your code', 'Invite friends to download BattleX.'),
            _buildStep(2, 'Friend signs up', 'They get ₹50 signup bonus instantly.'),
            _buildStep(3, 'You get ₹100', 'Once they play their first paid match.'),
            
            const SizedBox(height: 48),
            PrimaryButton(
              text: 'SHARE LINK NOW',
              icon: Icons.share,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int step, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryContainer),
            ),
            alignment: Alignment.center,
            child: Text(step.toString(), style: AppTextStyles.titleMd.copyWith(color: AppColors.primaryContainer)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
