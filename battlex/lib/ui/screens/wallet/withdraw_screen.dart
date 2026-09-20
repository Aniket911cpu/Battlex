import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/wallet_provider.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  void _handleWithdraw() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount < 10) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    final success = await ref.read(walletProvider.notifier).deductCash(amount, 'Cash Withdrawal');

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Insufficient withdrawable balance.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final withdrawable = walletState.balance * 0.6; // Mock withdrawable portion

    return Scaffold(
      appBar: const BattleXAppBar(title: 'Withdraw Winnings', showBackButton: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Withdrawable Balance
                    GlassContainer(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text('WITHDRAWABLE BALANCE', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                          const SizedBox(height: 8),
                          Text('₹${withdrawable.toInt()}', style: AppTextStyles.statNumeric.copyWith(color: AppColors.primaryContainer, fontSize: 40)),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.errorContainer.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.errorContainer.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline, color: AppColors.error, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text('30% TDS applicable on net winnings as per Govt. regulations.',
                                      style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Text('ENTER AMOUNT TO WITHDRAW', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.currency_rupee, color: AppColors.secondary),
                        hintText: 'Minimum ₹10',
                        hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.secondaryContainer),
                        filled: true,
                        fillColor: AppColors.surfaceContainerHigh,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    Text('SELECT WITHDRAWAL METHOD', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 12),
                    _buildWithdrawMethod('Linked Bank Account', 'State Bank of India •••• 1234', Icons.account_balance, true),
                    const SizedBox(height: 12),
                    _buildWithdrawMethod('Linked UPI ID', 'shadowninja@upi', Icons.qr_code, false),
                  ],
                ),
              ),
            ),
            
            // Withdraw CTA
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                border: Border(top: BorderSide(color: AppColors.surfaceContainerHigh)),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleWithdraw,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorContainer,
                  foregroundColor: AppColors.onErrorContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('WITHDRAW NOW', style: AppTextStyles.labelLg),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawMethod(String title, String subtitle, IconData icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.errorContainer.withValues(alpha: 0.1) : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? AppColors.errorContainer : AppColors.surfaceContainerHighest),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? AppColors.error : AppColors.secondary),
        title: Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
        subtitle: Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
        trailing: isSelected 
          ? const Icon(Icons.check_circle, color: AppColors.error)
          : const Icon(Icons.circle_outlined, color: AppColors.secondary),
      ),
    );
  }
}

