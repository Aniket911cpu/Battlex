import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Settings & Support', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          _buildSectionHeader('PREFERENCES'),
          _buildListTile(Icons.notifications, 'Notification Settings', 'Manage match alerts and promos', true),
          _buildListTile(Icons.volume_up, 'Sound & Haptics', 'In-app sound effects and vibration', true),
          
          const SizedBox(height: 24),
          _buildSectionHeader('SECURITY'),
          _buildListTile(Icons.security, 'Two-Factor Authentication', 'Add an extra layer of security', false),
          _buildListTile(Icons.password, 'Change Password', 'Update your login credentials', false),
          
          const SizedBox(height: 24),
          _buildSectionHeader('SUPPORT'),
          _buildListTile(Icons.chat, 'Live Chat Support', '24/7 assistance for match issues', false),
          _buildListTile(Icons.help_outline, 'FAQs & Help Center', 'Read guides and rules', false),
          _buildListTile(Icons.bug_report, 'Report an Issue', 'Found a bug or a hacker?', false),
          
          const SizedBox(height: 24),
          _buildSectionHeader('LEGAL'),
          _buildListTile(Icons.description, 'Terms of Service', '', false),
          _buildListTile(Icons.privacy_tip, 'Privacy Policy', '', false),
          _buildListTile(Icons.gavel, 'Fair Play Policy', 'Anti-cheat rules and penalties', false),
          
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorContainer.withOpacity(0.1),
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
            child: Text('BattleX v1.0.0 (Build 42)', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)),
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

  Widget _buildListTile(IconData icon, String title, String subtitle, bool hasToggle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.secondary),
      ),
      title: Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondaryContainer)) : null,
      trailing: hasToggle 
          ? Switch(
              value: true,
              onChanged: (v) {},
              activeColor: AppColors.primaryContainer,
              activeTrackColor: AppColors.primaryContainer.withOpacity(0.3),
            )
          : const Icon(Icons.chevron_right, color: AppColors.secondary),
      onTap: () {},
    );
  }
}
