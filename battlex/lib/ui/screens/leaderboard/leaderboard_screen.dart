import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/glass_container.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Leaderboard'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: AppColors.primaryContainer.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer, color: AppColors.primaryContainer, size: 16),
                const SizedBox(width: 8),
                Text('SEASON 12 ENDS IN 2D 14H', style: AppTextStyles.labelMd.copyWith(color: AppColors.primaryContainer)),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Podium
                  _buildPodium(),
                  const SizedBox(height: 32),
                  // List
                  _buildRankList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BattleXBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/my-matches');
          if (index == 4) context.go('/profile');
        },
      ),
    );
  }

  Widget _buildPodium() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Silver (2)
        _buildPodiumSpot(2, 'ViperXx', '₹45k', 120, AppColors.secondary),
        // Gold (1)
        _buildPodiumSpot(1, 'ShadowNinja', '₹68k', 160, AppColors.primaryContainer, isFirst: true),
        // Bronze (3)
        _buildPodiumSpot(3, 'GhostRecon', '₹32k', 100, AppColors.tertiary),
      ],
    );
  }

  Widget _buildPodiumSpot(int rank, String name, String earnings, double height, Color color, {bool isFirst = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isFirst) 
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.workspace_premium, color: AppColors.primaryContainer, size: 32),
          ),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainerHigh,
            border: Border.all(color: color, width: isFirst ? 3 : 2),
            boxShadow: isFirst ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 16)] : null,
          ),
          child: const Icon(Icons.person, color: AppColors.secondary), // Avatar placeholder
        ),
        const SizedBox(height: 8),
        Text(name, style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurface)),
        Text(earnings, style: AppTextStyles.titleMd.copyWith(color: color)),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            border: Border(top: BorderSide(color: color, width: 4)),
          ),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 8),
          child: Text('#$rank', style: AppTextStyles.headlineMd.copyWith(color: color.withOpacity(0.5))),
        ),
      ],
    );
  }

  Widget _buildRankList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (context, index) => const Divider(color: AppColors.surfaceContainerLowest, height: 1),
      itemBuilder: (context, index) {
        final rank = index + 4;
        final isMe = index == 3; // Simulate current user at rank 7

        return Container(
          color: isMe ? AppColors.primaryContainer.withOpacity(0.1) : AppColors.surfaceContainerLowest,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (isMe)
                Container(width: 4, height: 32, color: AppColors.primaryContainer, margin: const EdgeInsets.only(right: 12))
              else
                Container(width: 4, margin: const EdgeInsets.only(right: 12)),
              
              Text(
                rank.toString().padLeft(2, '0'),
                style: AppTextStyles.labelLg.copyWith(color: AppColors.secondary),
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.surfaceContainerHigh,
                child: const Icon(Icons.person, size: 20, color: AppColors.secondary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isMe ? 'You (Player123)' : 'Player_$rank', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                    Text('Win Rate: 4${5-index}%', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
                  ],
                ),
              ),
              Text('₹${25 - index}k', style: AppTextStyles.titleMd.copyWith(color: AppColors.primaryContainer)),
            ],
          ),
        );
      },
    );
  }
}
