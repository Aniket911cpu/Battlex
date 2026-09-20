import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/cyber_grid_bg.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleRegister() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      context.push('/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: CyberGridBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Join BattleX', style: AppTextStyles.headlineLg.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: 8),
                Text('Create an account to start dominating.', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                const SizedBox(height: 32),
                
                GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildInputLabel('USERNAME'),
                      _buildTextField(hint: 'e.g. ShadowNinja', icon: Icons.person),
                      const SizedBox(height: 20),
                      
                      _buildInputLabel('EMAIL OR MOBILE'),
                      _buildTextField(hint: 'player@battlex.pro', icon: Icons.alternate_email),
                      const SizedBox(height: 20),
                      
                      _buildInputLabel('PASSWORD'),
                      _buildTextField(
                        hint: '••••••••••••', 
                        icon: Icons.lock, 
                        isPassword: true,
                        obscure: _obscurePassword,
                        onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      const SizedBox(height: 32),
                      
                      PrimaryButton(
                        text: 'CREATE ACCOUNT',
                        isLoading: _isLoading,
                        onPressed: _handleRegister,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
    );
  }

  Widget _buildTextField({
    required String hint, 
    required IconData icon, 
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    return TextField(
      obscureText: obscure,
      style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.secondaryContainer),
        prefixIcon: Icon(icon, color: AppColors.secondary),
        suffixIcon: isPassword 
            ? IconButton(
                icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: AppColors.secondary),
                onPressed: onToggleObscure,
              )
            : null,
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
      ),
    );
  }
}

