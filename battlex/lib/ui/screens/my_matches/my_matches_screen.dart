import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/cards/match_history_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import '../../components/bottom_nav_bar.dart';

class MyMatchesScreen extends StatefulWidget {
  const MyMatchesScreen({super.key});

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'My Matches'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.primaryContainer,
            labelColor: AppColors.primaryContainer,
            unselectedLabelColor: AppColors.secondary,
            labelStyle: AppTextStyles.labelMd,
            tabs: const [
              Tab(text: 'ALL'),
              Tab(text: 'UPCOMING (1)'),
              Tab(text: 'LIVE'),
              Tab(text: 'RESULTS'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMatchList(), // All
                _buildMatchList(filter: 'UPCOMING'),
                _buildMatchList(filter: 'LIVE'),
                _buildMatchList(filter: 'COMPLETED'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BattleXBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 2) context.go('/leaderboard');
          if (index == 4) context.go('/profile');
        },
      ),
    );
  }

  Widget _buildMatchList({String? filter}) {
    // Dummy Data
    final matches = [
      {
        'title': 'BGMI Erangel Classic Squad',
        'gameMode': 'SQUAD',
        'date': 'Today, 09:00 PM',
        'status': 'UPCOMING',
      },
      {
        'title': 'Free Fire Lone Wolf',
        'gameMode': '1v1',
        'date': 'Today, 04:00 PM',
        'status': 'LIVE',
      },
      {
        'title': 'BGMI TDM 4v4',
        'gameMode': '4v4',
        'date': 'Yesterday',
        'status': 'COMPLETED',
        'rank': 1,
        'kills': 12,
        'winnings': '₹500',
      },
      {
        'title': 'Ludo King Challenge',
        'gameMode': '1v1',
        'date': 'Oct 15, 2026',
        'status': 'COMPLETED',
        'rank': 2,
        'kills': 0,
        'winnings': '₹0',
      },
    ];

    final filtered = filter == null 
        ? matches 
        : matches.where((m) => m['status'] == filter).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text('No matches found.', style: AppTextStyles.bodyLg.copyWith(color: AppColors.secondary)),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final match = filtered[index];
        return MatchHistoryCard(
          title: match['title'] as String,
          gameMode: match['gameMode'] as String,
          date: match['date'] as String,
          status: match['status'] as String,
          rank: match['rank'] as int?,
          kills: match['kills'] as int?,
          winnings: match['winnings'] as String?,
          onTap: () {
            // context.push('/match/123'); // or results page
          },
        );
      },
    );
  }
}
