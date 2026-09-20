import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/wallet_provider.dart';

class AddCashScreen extends ConsumerStatefulWidget {
  const AddCashScreen({super.key});

  @override
  ConsumerState<AddCashScreen> createState() => _AddCashScreenState();
}

class _AddCashScreenState extends ConsumerState<AddCashScreen> {
  final TextEditingController _amountController = TextEditingController(text: '100');
  bool _isLoading = false;

  void _handlePay() async {
    setState(() => _isLoading = true);
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount > 0) {
      await ref.read(walletProvider.notifier).addCash(amount);
    }
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Add Cash', showBackButton: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GlassContainer(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text('ENTER AMOUNT', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.statNumeric.copyWith(color: AppColors.onSurface),
                            decoration: InputDecoration(
                              prefixText: '₹',
                              prefixStyle: AppTextStyles.statNumeric.copyWith(color: AppColors.primaryContainer),
                              filled: true,
                              fillColor: AppColors.surfaceContainerHigh,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppColors.primaryContainer, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildAmountPreset('₹50'),
                              _buildAmountPreset('₹100'),
                              _buildAmountPreset('₹200'),
                              _buildAmountPreset('₹500'),
                              _buildAmountPreset('₹1000'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Text('SELECT PAYMENT METHOD', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 12),
                    _buildPaymentMethod('UPI', 'Google Pay, PhonePe, Paytm', Icons.qr_code, true),
                    const SizedBox(height: 12),
                    _buildPaymentMethod('Credit / Debit Cards', 'Visa, Mastercard, RuPay', Icons.credit_card, false),
                    const SizedBox(height: 12),
                    _buildPaymentMethod('Net Banking', 'All Indian Banks supported', Icons.account_balance, false),
                  ],
                ),
              ),
            ),
            
            // Payment Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                border: Border(top: BorderSide(color: AppColors.surfaceContainerHigh)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.security, color: AppColors.successGreen, size: 16),
                      const SizedBox(width: 8),
                      Text('100% SECURE TRANSACTIONS', style: AppTextStyles.labelSm.copyWith(color: AppColors.successGreen)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'PROCEED TO PAY',
                    isLoading: _isLoading,
                    onPressed: _handlePay,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountPreset(String amount) {
    return InkWell(
      onTap: () {
        _amountController.text = amount.replaceAll('₹', '');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.surfaceContainerHighest),
        ),
        child: Text(amount, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
      ),
    );
  }

  Widget _buildPaymentMethod(String title, String subtitle, IconData icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer.withOpacity(0.1) : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerHighest),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isSelected ? AppColors.primaryContainer : AppColors.secondary),
        ),
        title: Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
        subtitle: Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
        trailing: isSelected 
          ? const Icon(Icons.check_circle, color: AppColors.primaryContainer)
          : const Icon(Icons.circle_outlined, color: AppColors.secondary),
      ),
    );
  }
}
