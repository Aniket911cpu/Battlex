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
                        _buildHubAction(Icons.science, 'Labs', () => context.push('/labs')),
                        _buildHubAction(Icons.group_add, 'Refer', () => context.push('/refer')),
                        _buildHubAction(Icons.diamond, 'VIP Pass', () => context.push('/membership')),
                        _buildHubAction(Icons.support_agent, 'Support', () => context.push('/settings')),
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
      appBar: const BattleXAppBar(title: 'BattleX'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Win Ticker
            Container(
              height: 40,
              color: AppColors.surfaceContainerHigh,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(Icons.emoji_events, color: AppColors.tertiary, size: 16),
                          const SizedBox(width: 8),
                          Text('ShadowNinja won ₹5,000 in BGMI Squads', 
                            style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
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
                          Text('WELCOME BACK,', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                          Text(user?.username.toUpperCase() ?? 'GAMER', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.primaryContainer),
                            ),
                            child: Text('PRO PLAYER', style: AppTextStyles.labelSm.copyWith(color: AppColors.primaryContainer)),
                          ),
                        ],
                      ),
                    ),
                    Image.network('https://placeholder.com/100x100', width: 80, height: 80),
                  ],
                ),
              ),
            ),

            // Quick Actions Hub
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(context, Icons.science, 'Labs', '/labs'),
                  _buildQuickAction(context, Icons.group_add, 'Refer', '/refer'),
                  _buildQuickAction(context, Icons.diamond, 'VIP Pass', '/membership'),
                  _buildQuickAction(context, Icons.support_agent, 'Support', '/settings'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Game Filters
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildGameFilter('All'),
                  _buildGameFilter('BGMI'),
                  _buildGameFilter('Free Fire'),
                  _buildGameFilter('Ludo'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tournaments List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('LIVE & UPCOMING', style: AppTextStyles.titleLg.copyWith(color: AppColors.onSurface)),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredMatches.length,
              itemBuilder: (context, index) {
                final match = filteredMatches[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TournamentCard(
                    title: match.title,
                    game: match.game,
                    time: match.time,
                    prizePool: '₹${match.prizePool}',
                    entryFee: match.entryFee == 0 ? 'FREE' : '₹${match.entryFee}',
                    totalSpots: match.totalSpots,
                    filledSpots: match.filledSpots,
                    onTap: () => context.push('/match/details'), // In a real app we'd pass matchId
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
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

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () => context.push(route),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceContainerHighest),
            ),
            child: Icon(icon, color: AppColors.secondary, size: 24),
          ),
          const SizedBox(height: 8),
}
