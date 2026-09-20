import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/glass_container.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import '../../../data/providers/user_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: const BattleXAppBar(title: 'Gamer Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryContainer, width: 3),
                          image: const DecorationImage(
                            image: NetworkImage('https://placeholder.com/150x150'), // Avatar placeholder
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryContainer),
                        ),
                        child: const Icon(Icons.edit, size: 16, color: AppColors.primaryContainer),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(user.username, style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ID: ${user.id}', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                      const SizedBox(width: 8),
                      if (user.vipTier != 'NONE')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryContainer.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.tertiaryContainer),
                          ),
                          child: Text('${user.vipTier} VIP', style: AppTextStyles.labelSm.copyWith(color: AppColors.tertiary)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () => context.push('/profile/edit'),
                    icon: const Icon(Icons.settings, color: AppColors.primaryContainer, size: 18),
                    label: Text('EDIT PROFILE', style: AppTextStyles.labelMd.copyWith(color: AppColors.primaryContainer)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Grid
            Text('CAREER STATS', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('MATCHES PLAYED', '142'),
                _buildStatCard('WIN RATE', '68%'),
                _buildStatCard('TOTAL EARNINGS', '₹1.2L'),
                _buildStatCard('K/D RATIO', '4.2'),
              ],
            ),
            const SizedBox(height: 24),

            // Game IDs
            Text('LINKED ACCOUNTS', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
            const SizedBox(height: 12),
            GlassContainer(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  _buildGameIdRow('BGMI ID', user.bgmiId ?? 'Not Linked', user.bgmiId != null),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildGameIdRow('Free Fire ID', user.freeFireId ?? 'Not Linked', user.freeFireId != null),
                  const Divider(color: AppColors.surfaceContainerLowest, height: 1),
                  _buildGameIdRow('Ludo ID', user.ludoId ?? 'Not Linked', user.ludoId != null),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BattleXBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/my-matches');
          if (index == 2) context.go('/leaderboard');
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: AppTextStyles.statNumeric.copyWith(color: AppColors.primaryContainer, fontSize: 28)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
        ],
      ),
    );
  }

  Widget _buildGameIdRow(String game, String id, bool isLinked) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(game, style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface)),
          Row(
            children: [
              Text(
                id, 
                style: AppTextStyles.titleMd.copyWith(color: isLinked ? AppColors.secondary : AppColors.error)
              ),
              if (!isLinked) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {}, // Link action
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                  ),
                  child: Text('LINK', style: AppTextStyles.labelSm.copyWith(color: AppColors.primaryContainer)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

