import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/cyber_grid_bg.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
      // context.go('/home'); // Will go to home once Phase 3 is ready
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CyberGridBg(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with Aura
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGlow.withOpacity(0.4),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text('BX', style: AppTextStyles.headlineLg.copyWith(color: AppColors.primaryContainer)),
                  ),
                  const SizedBox(height: 32),
                  
                  // Login Glass Card
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Row(
                          children: [
                            Text('Welcome Back!', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface)),
                            const SizedBox(width: 8),
                            const Icon(Icons.sports_esports, color: AppColors.primaryContainer, size: 28),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Login to continue your gaming journey', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                        const SizedBox(height: 32),
                        
                        // Email/Mobile Input
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('MOBILE NUMBER OR EMAIL', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
                            Text('BATTLEX ID', style: AppTextStyles.labelSm.copyWith(color: AppColors.primaryContainer)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
                          decoration: InputDecoration(
                            hintText: 'player@battlex.pro or +91...',
                            hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.secondaryContainer),
                            prefixIcon: const Icon(Icons.alternate_email, color: AppColors.secondary),
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
                        ),
                        const SizedBox(height: 24),
                        
                        // Password Input
                        Text('PASSWORD', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: _obscurePassword,
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
                          decoration: InputDecoration(
                            hintText: '••••••••••••',
                            hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.secondaryContainer),
                            prefixIcon: const Icon(Icons.lock, color: AppColors.secondary),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: AppColors.secondary),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
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
                        ),
                        const SizedBox(height: 16),
                        
                        // Controls Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (val) => setState(() => _rememberMe = val ?? false),
                                  activeColor: AppColors.primaryContainer,
                                  checkColor: AppColors.onPrimaryContainer,
                                  side: const BorderSide(color: AppColors.secondary),
                                ),
                                Text('Remember me', style: AppTextStyles.labelMd.copyWith(color: AppColors.secondary)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Forgot Password?', style: AppTextStyles.labelMd.copyWith(color: AppColors.primaryContainer)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        PrimaryButton(
                          text: 'SIGN IN',
                          icon: Icons.login,
                          isLoading: _isLoading,
                          onPressed: _handleLogin,
                        ),
                        
                        const SizedBox(height: 32),
                        // Divider
                        Row(
                          children: [
                            const Expanded(child: Divider(color: AppColors.surfaceContainerHighest)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text('OR CONTINUE WITH', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary)),
                            ),
                            const Expanded(child: Divider(color: AppColors.surfaceContainerHighest)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Google Auth
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceBright,
                            foregroundColor: AppColors.onSurface,
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          icon: const Icon(Icons.g_mobiledata, size: 32),
                          label: const Text('Sign in with Google'),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                      TextButton(
                        onPressed: () => context.go('/register'),
                        child: Text('SIGN UP', style: AppTextStyles.labelLg.copyWith(color: AppColors.primaryContainer)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified_user, size: 16, color: AppColors.secondaryContainer),
                      const SizedBox(width: 8),
                      Text('ANTI-CHEAT & ESCROW GUARANTEED', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondaryContainer)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
