import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;

  void _handleLogout() async {
    await ref.read(authProvider.notifier).logout();
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Settings & Support', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          _buildSectionHeader('PREFERENCES'),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            leading: _buildIcon(Icons.notifications),
            title: Text('Notification Settings', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
            subtitle: Text('Manage match alerts and promos', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
              activeThumbColor: AppColors.primaryContainer,
              activeTrackColor: AppColors.primaryContainer.withValues(alpha: 0.3),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            leading: _buildIcon(Icons.volume_up),
            title: Text('Sound & Haptics', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
            subtitle: Text('In-app sound effects and vibration', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
            trailing: Switch(
              value: _soundEnabled,
              onChanged: (v) => setState(() => _soundEnabled = v),
              activeThumbColor: AppColors.primaryContainer,
              activeTrackColor: AppColors.primaryContainer.withValues(alpha: 0.3),
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('SECURITY'),
          _buildNavTile(Icons.security, 'Two-Factor Authentication', 'Add an extra layer of security'),
          _buildNavTile(Icons.password, 'Change Password', 'Update your login credentials'),

          const SizedBox(height: 24),
          _buildSectionHeader('SUPPORT'),
          _buildNavTile(Icons.chat, 'Live Chat Support', '24/7 assistance for match issues'),
          _buildNavTile(Icons.help_outline, 'FAQs & Help Center', 'Read guides and rules'),
          _buildNavTile(Icons.bug_report, 'Report an Issue', 'Found a bug or a hacker?'),

          const SizedBox(height: 24),
          _buildSectionHeader('LEGAL'),
          _buildNavTile(Icons.description, 'Terms of Service', ''),
          _buildNavTile(Icons.privacy_tip, 'Privacy Policy', ''),
          _buildNavTile(Icons.gavel, 'Fair Play Policy', 'Anti-cheat rules and penalties'),

          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: _handleLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorContainer.withValues(alpha: 0.1),
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: Text('LOG OUT', style: AppTextStyles.labelLg),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text('BattleX v1.0.0 (Build 42)',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Text(title, style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: AppColors.secondary),
    );
  }

  Widget _buildNavTile(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      leading: _buildIcon(icon),
      title: Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer))
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.secondary),
      onTap: () {},
    );
  }
}

