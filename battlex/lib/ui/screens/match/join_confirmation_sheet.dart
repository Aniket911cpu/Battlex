import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/wallet_provider.dart';
import '../../../data/providers/match_provider.dart';

class JoinConfirmationSheet extends ConsumerStatefulWidget {
  const JoinConfirmationSheet({super.key});

  @override
  ConsumerState<JoinConfirmationSheet> createState() => _JoinConfirmationSheetState();
}

class _JoinConfirmationSheetState extends ConsumerState<JoinConfirmationSheet> {
  bool _isLoading = false;

  void _handleConfirm() async {
    setState(() => _isLoading = true);

    final success = await ref.read(matchProvider.notifier).joinMatch('M1');

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Successfully joined the match!'
              : 'Failed to join. Check your balance or match capacity.'),
          backgroundColor:
              success ? AppColors.successGreen : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final entryFee = 50.0;
    final hasSufficientBalance = walletState.balance >= entryFee;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CONFIRM ENTRY', style: AppTextStyles.titleLg.copyWith(color: AppColors.onSurface)),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.secondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Match Details Summary
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.sports_esports, color: AppColors.primaryContainer),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BGMI Erangel Squads', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                      Text('Today, 09:00 PM', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.surfaceContainerHighest, height: 1),
            const SizedBox(height: 24),
            
            // Payment Summary
            _buildSummaryRow('Entry Fee', '₹$entryFee'),
            const SizedBox(height: 12),
            _buildSummaryRow('Bonus Cash Usable', '-₹0', isDiscount: true),
            const SizedBox(height: 16),
            const Divider(color: AppColors.surfaceContainerLowest, height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('To Pay', style: AppTextStyles.titleLg.copyWith(color: AppColors.onSurface)),
                Text('₹$entryFee', style: AppTextStyles.titleLg.copyWith(color: AppColors.primaryContainer)),
              ],
            ),
            const SizedBox(height: 24),
            
            // Current Balance
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: hasSufficientBalance 
                    ? AppColors.surfaceContainerHigh 
                    : AppColors.errorContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hasSufficientBalance 
                      ? AppColors.surfaceContainerHighest 
                      : AppColors.error,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, 
                        color: hasSufficientBalance ? AppColors.secondary : AppColors.error, 
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text('Wallet Balance', style: AppTextStyles.bodyMd.copyWith(
                        color: hasSufficientBalance ? AppColors.secondary : AppColors.error,
                      )),
                    ],
                  ),
                  Text('₹${walletState.balance.toInt()}', style: AppTextStyles.titleMd.copyWith(
                    color: hasSufficientBalance ? AppColors.onSurface : AppColors.error,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Button
            PrimaryButton(
              text: hasSufficientBalance ? 'CONFIRM & JOIN' : 'ADD CASH TO JOIN',
              isLoading: _isLoading,
              onPressed: () {
                if (hasSufficientBalance) {
                  _handleConfirm();
                } else {
                  Navigator.pop(context); // Close sheet
                  // Navigator.pushNamed(context, '/wallet/add-cash');
                  // Since we are using GoRouter, would use context.push but we popped. 
                  // In real app, use callback.
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
        Text(value, style: AppTextStyles.titleMd.copyWith(
          color: isDiscount ? AppColors.successGreen : AppColors.onSurface,
        )),
      ],
    );
  }
}

