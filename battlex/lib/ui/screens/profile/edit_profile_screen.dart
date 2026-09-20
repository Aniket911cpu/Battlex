import 'package:flutter/material.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;

  void _handleSave() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BattleXAppBar(title: 'Edit Profile', showBackButton: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Avatar Edit
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryContainer, width: 2),
                              color: AppColors.surfaceContainerHigh,
                            ),
                            child: const Icon(Icons.person, size: 48, color: AppColors.secondary),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, size: 16, color: AppColors.onPrimaryContainer),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    Text('PERSONAL INFO', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 12),
                    GlassContainer(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildTextField('Username', 'ShadowNinja', Icons.person),
                          const SizedBox(height: 16),
                          _buildTextField('Email', 'player@battlex.pro', Icons.email, isReadOnly: true),
                          const SizedBox(height: 16),
                          _buildTextField('Mobile Number', '+91 9876543210', Icons.phone, isReadOnly: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Text('GAME ACCOUNTS', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 12),
                    GlassContainer(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildTextField('BGMI ID', '51239847192', Icons.sports_esports),
                          const SizedBox(height: 16),
                          _buildTextField('Free Fire ID', '', Icons.sports_esports, hint: 'Enter Free Fire ID'),
                          const SizedBox(height: 16),
                          _buildTextField('Ludo Name', 'Shadow_Ludo', Icons.sports_esports),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Save Button
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                border: Border(top: BorderSide(color: AppColors.surfaceContainerHigh)),
              ),
              child: PrimaryButton(
                text: 'SAVE CHANGES',
                isLoading: _isLoading,
                onPressed: _handleSave,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, IconData icon, {bool isReadOnly = false, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          readOnly: isReadOnly,
          style: AppTextStyles.bodyMd.copyWith(color: isReadOnly ? AppColors.secondary : AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.secondaryContainer),
            prefixIcon: Icon(icon, color: AppColors.secondary, size: 20),
            filled: true,
            fillColor: AppColors.surfaceContainerHigh,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryContainer),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
