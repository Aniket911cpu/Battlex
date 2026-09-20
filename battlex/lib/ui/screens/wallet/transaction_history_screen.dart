import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final transactions = [
      {'title': 'Winnings - BGMI Match', 'date': 'Today, 10:30 PM', 'amount': '+₹500', 'type': 'credit', 'status': 'SUCCESS'},
      {'title': 'Entry Fee - BGMI Match', 'date': 'Today, 09:00 PM', 'amount': '-₹50', 'type': 'debit', 'status': 'SUCCESS'},
      {'title': 'Cash Withdrawal', 'date': 'Yesterday, 04:15 PM', 'amount': '-₹1,500', 'type': 'debit', 'status': 'PENDING'},
      {'title': 'Cash Deposit', 'date': 'Oct 15, 2026', 'amount': '+₹200', 'type': 'credit', 'status': 'SUCCESS'},
      {'title': 'Referral Bonus', 'date': 'Oct 10, 2026', 'amount': '+₹50', 'type': 'credit', 'status': 'SUCCESS'},
    ];

    return Scaffold(
      appBar: const BattleXAppBar(title: 'Transaction History', showBackButton: true),
      body: Column(
        children: [
          // Filter Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('Deposits', false),
                _buildFilterChip('Withdrawals', false),
                _buildFilterChip('Winnings', false),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const Divider(color: AppColors.surfaceContainerLowest, height: 1),
              itemBuilder: (context, index) {
                final t = transactions[index];
                final isCredit = t['type'] == 'credit';
                final isPending = t['status'] == 'PENDING';
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isCredit ? AppColors.successGreen : AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t['title']!, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(t['date']!, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                                if (isPending) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.tertiaryContainer.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text('PENDING', style: AppTextStyles.labelSm.copyWith(color: AppColors.tertiary, fontSize: 8)),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        t['amount']!, 
                        style: AppTextStyles.titleMd.copyWith(
                          color: isCredit ? AppColors.successGreen : AppColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer.withOpacity(0.2) : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerHighest),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMd.copyWith(color: isSelected ? AppColors.primaryContainer : AppColors.secondary),
      ),
    );
  }
}
