import 'package:flutter/material.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class JoinConfirmationSheet extends StatefulWidget {
  final double entryFee;
  final double balance;

  const JoinConfirmationSheet({
    super.key,
    required this.entryFee,
    required this.balance,
  });

  @override
  State<JoinConfirmationSheet> createState() => _JoinConfirmationSheetState();
}

class _JoinConfirmationSheetState extends State<JoinConfirmationSheet> {
  bool _isLoading = false;

  void _handleConfirm() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
      context.pop(); // Close sheet
      
      // Show success toast (using scaffold messenger for now)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Successfully joined the match!'),
            ],
          ),
          backgroundColor: AppColors.successGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasEnoughBalance = widget.balance >= widget.entryFee;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            Text('Confirm Entry', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
            const SizedBox(height: 24),
            
            GlassContainer(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Entry Fee', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                      Text('₹${widget.entryFee.toInt()}', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: AppColors.surfaceContainerHighest),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Current Balance', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                      Text('₹${widget.balance.toInt()}', style: AppTextStyles.titleMd.copyWith(
                        color: hasEnoughBalance ? AppColors.successGreen : AppColors.error,
                      )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            if (!hasEnoughBalance)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.errorContainer),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Insufficient balance. Please add cash to your wallet to join this match.',
                        style: AppTextStyles.bodySm.copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),

            PrimaryButton(
              text: hasEnoughBalance ? 'CONFIRM & PAY ₹${widget.entryFee.toInt()}' : 'ADD CASH',
              isLoading: _isLoading,
              onPressed: hasEnoughBalance ? _handleConfirm : () {
                // Navigate to add cash
                context.pop();
                context.push('/wallet/add-cash');
              },
            ),
          ],
        ),
      ),
    );
  }
}
