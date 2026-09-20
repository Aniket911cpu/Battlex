import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/app_bar/battlex_app_bar.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/user_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  bool _isLoading = false;
  late TextEditingController _usernameCtrl;
  late TextEditingController _bgmiCtrl;
  late TextEditingController _freeFireCtrl;
  late TextEditingController _ludoCtrl;

  @override
  void initState() {
    super.initState();
    // Controllers will be initialized in build where we can read ref safely, 
    // or we can use ref.read if we delay. 
    _usernameCtrl = TextEditingController();
    _bgmiCtrl = TextEditingController();
    _freeFireCtrl = TextEditingController();
    _ludoCtrl = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ref.read(userProvider);
    if (user != null && _usernameCtrl.text.isEmpty) {
      _usernameCtrl.text = user.username;
      _bgmiCtrl.text = user.bgmiId ?? '';
      _freeFireCtrl.text = user.freeFireId ?? '';
      _ludoCtrl.text = user.ludoId ?? '';
    }
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _bgmiCtrl.dispose();
    _freeFireCtrl.dispose();
    _ludoCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      final user = ref.read(userProvider);
      if (user != null) {
        final updated = user.copyWith(
          username: _usernameCtrl.text,
          bgmiId: _bgmiCtrl.text.isEmpty ? null : _bgmiCtrl.text,
          freeFireId: _freeFireCtrl.text.isEmpty ? null : _freeFireCtrl.text,
          ludoId: _ludoCtrl.text.isEmpty ? null : _ludoCtrl.text,
        );
        ref.read(userProvider.notifier).updateUser(updated);
      }
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                          _buildTextField('Username', Icons.person, controller: _usernameCtrl),
                          const SizedBox(height: 16),
                          _buildTextField('Email', Icons.email, isReadOnly: true, value: user.email ?? 'Not provided'),
                          const SizedBox(height: 16),
                          _buildTextField('Mobile Number', Icons.phone, isReadOnly: true, value: user.phone),
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
                          _buildTextField('BGMI ID', Icons.sports_esports, controller: _bgmiCtrl),
                          const SizedBox(height: 16),
                          _buildTextField('Free Fire ID', Icons.sports_esports, hint: 'Enter Free Fire ID', controller: _freeFireCtrl),
                          const SizedBox(height: 16),
                          _buildTextField('Ludo Name', Icons.sports_esports, controller: _ludoCtrl),
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

  Widget _buildTextField(String label, IconData icon, {bool isReadOnly = false, String? hint, TextEditingController? controller, String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          controller: controller,
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

