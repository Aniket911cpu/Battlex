import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class BattleXAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String? title;

  const BattleXAppBar({
    super.key,
    this.showBackButton = false,
    this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surfaceContainerLowest.withOpacity(0.95),
      elevation: 0,
      centerTitle: false,
      leading: showBackButton 
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
            onPressed: () => Navigator.of(context).pop(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: Text('BX', style: AppTextStyles.titleMd.copyWith(color: AppColors.primaryContainer)),
            ),
          ),
      leadingWidth: showBackButton ? 56 : 48,
      title: title != null 
        ? Text(title!, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface))
        : null,
      actions: [
        // Wallet Pill
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryContainer.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_balance_wallet, size: 14, color: AppColors.primaryContainer),
              const SizedBox(width: 6),
              Text('₹2,450', style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurface)),
              const SizedBox(width: 4),
              const Icon(Icons.add_circle, size: 16, color: AppColors.primaryContainer),
            ],
          ),
        ),
        
        // Notifications
        IconButton(
          icon: const Badge(
            backgroundColor: AppColors.primaryContainer,
            smallSize: 8,
            child: Icon(Icons.notifications_outlined, color: AppColors.onSurface),
          ),
          onPressed: () => GoRouter.of(context).push('/notifications'),
        ),
        
        // Avatar
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 4.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainerHigh,
            child: const Icon(Icons.person, size: 20, color: AppColors.secondary),
          ),
        ),
      ],
    );
  }
}
