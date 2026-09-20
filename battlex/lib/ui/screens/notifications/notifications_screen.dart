import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final notifications = [
      {'title': 'Match Starting Soon!', 'body': 'Your BGMI Squad match starts in 15 mins. Room ID is now available.', 'time': 'Just now', 'icon': Icons.sports_esports, 'unread': true},
      {'title': 'Withdrawal Successful', 'body': '₹1,500 has been credited to your linked UPI account.', 'time': '2h ago', 'icon': Icons.account_balance_wallet, 'unread': false},
      {'title': 'Referral Bonus Added', 'body': 'Your friend joined! ₹100 bonus cash has been added to your wallet.', 'time': 'Yesterday', 'icon': Icons.group_add, 'unread': false},
    ];

    return Scaffold(
      appBar: const BattleXAppBar(title: 'Notifications', showBackButton: true),
      body: Column(
        children: [
          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('Matches', false),
                _buildFilterChip('Wallet', false),
                _buildFilterChip('System', false),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(color: AppColors.surfaceContainerLowest, height: 1),
              itemBuilder: (context, index) {
                final n = notifications[index];
                final bool isUnread = n['unread'] as bool;
                
                return Container(
                  color: isUnread ? AppColors.primaryContainer.withOpacity(0.05) : Colors.transparent,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          shape: BoxShape.circle,
                          border: isUnread ? Border.all(color: AppColors.primaryContainer) : null,
                        ),
                        child: Icon(n['icon'] as IconData, color: isUnread ? AppColors.primaryContainer : AppColors.secondary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n['title'] as String, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                            const SizedBox(height: 4),
                            Text(n['body'] as String, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                            const SizedBox(height: 8),
                            Text(n['time'] as String, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondaryContainer)),
                          ],
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: AppColors.primaryGlow.withOpacity(0.5), blurRadius: 4)],
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
