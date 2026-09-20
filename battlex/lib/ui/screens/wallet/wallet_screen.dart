import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import '../../../data/providers/wallet_provider.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  final int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Wallet'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Total Balance Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGlow.withValues(alpha: 0.15),
                    blurRadius: 32,
                    spreadRadius: -8,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text('TOTAL BALANCE', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                  const SizedBox(height: 8),
                  Text('₹${walletState.balance.toInt()}', style: AppTextStyles.statNumeric.copyWith(color: AppColors.onSurface, fontSize: 48)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.successGreen, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text('Updated Just Now', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: 'ADD CASH',
                          icon: Icons.add_circle_outline,
                          onPressed: () => context.push('/wallet/add-cash'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/wallet/withdraw'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceBright,
                            foregroundColor: AppColors.onSurface,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: const Icon(Icons.account_balance),
                          label: const Text('WITHDRAW'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // KYC Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.successGreen.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified, color: AppColors.successGreen),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('KYC Verified', style: AppTextStyles.titleMd.copyWith(color: AppColors.successGreen)),
                        Text('Daily withdrawal limit: ₹50,000', style: AppTextStyles.bodySm.copyWith(color: AppColors.successGreen)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Breakdown (Mock split)
            Text('BALANCE BREAKDOWN', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
            const SizedBox(height: 12),
            GlassContainer(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  _buildBreakdownRow('Play Money (Deposits)', '₹${(walletState.balance * 0.3).toInt()}', 'Unrestricted use for matches', Colors.transparent),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildBreakdownRow('Winnings', '₹${(walletState.balance * 0.6).toInt()}', 'Withdrawable to bank', AppColors.primaryContainer),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildBreakdownRow('Bonus Cash', '₹${(walletState.balance * 0.1).toInt()}', 'Used in specific matches', AppColors.tertiary),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Transactions Link
            GlassContainer(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: const Icon(Icons.history, color: AppColors.primaryContainer),
                title: Text('Transaction History', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                subtitle: Text('View deposits, withdrawals & winnings', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                trailing: const Icon(Icons.chevron_right, color: AppColors.secondary),
                onTap: () => context.push('/wallet/transactions'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BattleXBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/my-matches');
          if (index == 2) context.go('/leaderboard');
          if (index == 4) context.go('/profile');
        },
      ),
    );
  }

  Widget _buildBreakdownRow(String title, String amount, String subtitle, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: accentColor, width: 4)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
            ],
          ),
          Text(amount, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
        ],
      ),
    );
  }
}

