import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/glass_container.dart';
import '../../components/win_ticker.dart';
import '../../components/cards/tournament_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/match_provider.dart';
import '../../../data/providers/user_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final int _currentIndex = 0;
  String _selectedGame = 'All';

  @override
  Widget build(BuildContext context) {
    final matches = ref.watch(matchProvider);
    final user = ref.watch(userProvider);

    final filteredMatches = _selectedGame == 'All'
        ? matches
        : matches.where((m) => m.game == _selectedGame).toList();

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
                  // Hero Welcome Banner
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('WELCOME BACK,',
                                    style: AppTextStyles.labelSm
                                        .copyWith(color: AppColors.secondary)),
                                Text(
                                    user?.username.toUpperCase() ?? 'GAMER',
                                    style: AppTextStyles.headlineMd
                                        .copyWith(color: AppColors.onSurface)),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryContainer
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: AppColors.primaryContainer),
                                  ),
                                  child: Text('PRO PLAYER',
                                      style: AppTextStyles.labelSm.copyWith(
                                          color: AppColors.primaryContainer)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.primaryContainer
                                      .withValues(alpha: 0.4)),
                            ),
                            child: const Icon(Icons.sports_esports,
                                color: AppColors.primaryContainer, size: 36),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Quick Actions Hub
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildHubAction(context, Icons.science, 'Labs', '/labs'),
                        _buildHubAction(context, Icons.group_add, 'Refer', '/refer'),
                        _buildHubAction(context, Icons.diamond, 'VIP Pass', '/membership'),
                        _buildHubAction(context, Icons.support_agent, 'Support', '/settings'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Container(
                            width: 4,
                            height: 16,
                            color: AppColors.primaryContainer),
                        const SizedBox(width: 8),
                        Text('EXCLUSIVE MATCHES',
                            style: AppTextStyles.labelLg
                                .copyWith(color: AppColors.onSurface)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Game Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        _buildFilterChip('All'),
                        _buildFilterChip('BGMI'),
                        _buildFilterChip('Free Fire'),
                        _buildFilterChip('Ludo'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tournaments List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredMatches.length,
                    itemBuilder: (context, index) {
                      final match = filteredMatches[index];
                      final progress = match.totalSpots > 0
                          ? match.filledSpots / match.totalSpots
                          : 0.0;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TournamentCard(
                          title: match.title,
                          gameMode: match.game,
                          matchType: match.filledSpots >= match.totalSpots
                              ? 'FULL'
                              : 'OPEN',
                          prizePool: '₹${match.prizePool}',
                          entryFee:
                              match.entryFee == 0 ? 'FREE' : '₹${match.entryFee}',
                          capacityProgress: progress,
                          filledLabel:
                              '${match.filledSpots}/${match.totalSpots}',
                          leftLabel:
                              '${match.totalSpots - match.filledSpots} LEFT',
                          isLive: match.filledSpots > match.totalSpots * 0.5,
                          onTap: () => context.push('/match/${match.id}'),
                        ),
                      );
                    },
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
          if (index == 1) context.go('/my-matches');
          if (index == 2) context.go('/leaderboard');
          if (index == 3) context.go('/wallet');
          if (index == 4) context.go('/profile');
        },
      ),
    );
  }

  Widget _buildHubAction(
      BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Column(
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
          Text(label,
              style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String game) {
    final isSelected = _selectedGame == game;
    return GestureDetector(
      onTap: () => setState(() => _selectedGame = game),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer.withValues(alpha: 0.2)
              : AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected
                  ? AppColors.primaryContainer
                  : AppColors.surfaceContainerHighest),
        ),
        child: Text(
          game,
          style: AppTextStyles.labelMd.copyWith(
              color: isSelected
                  ? AppColors.primaryContainer
                  : AppColors.secondary),
        ),
      ),
    );
  }
}
