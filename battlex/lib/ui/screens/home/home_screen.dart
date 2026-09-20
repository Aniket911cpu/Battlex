import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/win_ticker.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/cards/tournament_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(),
      body: Column(
        children: [
          const WinTicker(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Banner
                  Container(
                    height: 180,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://placeholder.com/600x400'), // Replace with actual asset
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                      ),
                      border: Border.all(color: AppColors.primaryContainer.withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('MEGA TOURNAMENT', style: AppTextStyles.labelSm.copyWith(color: AppColors.onPrimaryContainer)),
                        ),
                        const SizedBox(height: 8),
                        Text('BGMI PRO LEAGUE', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                        Text('₹50,000 PRIZE POOL', style: AppTextStyles.statNumeric.copyWith(color: AppColors.primaryContainer, fontSize: 24)),
                      ],
                    ),
                  ),

                  // Quick Actions Hub
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHubAction(Icons.emoji_events, 'My Stats'),
                        _buildHubAction(Icons.group_add, 'Refer'),
                        _buildHubAction(Icons.diamond, 'VIP Pass'),
                        _buildHubAction(Icons.support_agent, 'Support'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Container(width: 4, height: 16, color: AppColors.primaryContainer),
                        const SizedBox(width: 8),
                        Text('EXCLUSIVE MATCHES', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        _buildFilterChip('All Games', true),
                        _buildFilterChip('BGMI', false),
                        _buildFilterChip('Free Fire', false),
                        _buildFilterChip('Ludo', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tournaments List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TournamentCard(
                          title: 'BGMI Erangel Classic Squad',
                          gameMode: 'SQUAD',
                          matchType: 'CLASSIC',
                          prizePool: '₹2,500',
                          entryFee: '₹50',
                          capacityProgress: 0.84,
                          filledLabel: '84/100',
                          leftLabel: '16 LEFT',
                          isLive: true,
                          onTap: () => context.push('/match/1'),
                        ),
                        const SizedBox(height: 16),
                        TournamentCard(
                          title: 'Free Fire Clash Squad 4v4',
                          gameMode: '4v4',
                          matchType: 'TDM',
                          prizePool: '₹1,000',
                          entryFee: '₹20',
                          capacityProgress: 0.35,
                          filledLabel: '14/40',
                          leftLabel: '26 LEFT',
                          isLive: false,
                          onTap: () => context.push('/match/2'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BattleXBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) context.go('/my-matches');
            if (index == 2) context.go('/leaderboard');
            if (index == 4) context.go('/profile');
          });
        },
      ),
    );
  }

  Widget _buildHubAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surfaceContainerHighest),
          ),
          child: Icon(icon, color: AppColors.primaryContainer, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
      ],
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
