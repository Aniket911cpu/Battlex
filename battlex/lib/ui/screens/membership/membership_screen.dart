import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'VIP Membership', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Tier
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.tertiaryContainer.withOpacity(0.8), AppColors.surfaceContainerHigh],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.tertiary),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.tertiary.withOpacity(0.2),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.diamond, size: 48, color: AppColors.tertiary),
                  const SizedBox(height: 12),
                  Text('DIAMOND TIER', style: AppTextStyles.headlineMd.copyWith(color: AppColors.tertiary, letterSpacing: 2)),
                  const SizedBox(height: 4),
                  Text('Active until Dec 31, 2026', style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurface)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            Text('YOUR BENEFITS', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
            const SizedBox(height: 16),
            GlassContainer(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  _buildBenefitRow(Icons.bolt, 'Instant Withdrawals', 'No waiting time for bank transfers'),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildBenefitRow(Icons.money_off, '0% Platform Fee', 'Keep 100% of your winnings in custom rooms'),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildBenefitRow(Icons.support_agent, 'Priority Support', '24/7 dedicated VIP chat support'),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildBenefitRow(Icons.emoji_events, 'Exclusive Tournaments', 'Access to high-roller VIP only matches'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            Text('UPGRADE TIER', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
            const SizedBox(height: 16),
            
            // Upcoming Tier
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('CONQUEROR', style: AppTextStyles.titleMd.copyWith(color: AppColors.primaryContainer, letterSpacing: 1)),
                      Text('₹999 / mo', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Includes all Diamond benefits plus a custom profile badge and free entry to 5 Mega Tournaments per month.', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'UPGRADE NOW',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.tertiary),
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
