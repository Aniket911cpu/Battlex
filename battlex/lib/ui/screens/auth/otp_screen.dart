import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/cyber_grid_bg.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/providers/auth_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final int _otpLength = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (index) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in _controllers) { c.dispose(); }
    for (var f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  void _verifyOtp() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      await ref.read(authProvider.notifier).login('+91 9876543210');
      setState(() => _isLoading = false);
      context.go('/home');
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Verification',
                    style: AppTextStyles.headlineLg.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: 8),
                Text('We sent a 6-digit code to your mobile number',
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                const SizedBox(height: 48),
                GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(_otpLength, (index) {
                          return SizedBox(
                            width: 44,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: AppTextStyles.headlineMd
                                  .copyWith(color: AppColors.onSurface),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.surfaceContainerHigh,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryContainer),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < _otpLength - 1) {
                                  _focusNodes[index + 1].requestFocus();
                                } else if (value.isEmpty && index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                                if (index == _otpLength - 1 && value.isNotEmpty) {
                                  _verifyOtp();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: 'VERIFY',
                        isLoading: _isLoading,
                        onPressed: _verifyOtp,
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {},
                        child: Text('RESEND CODE (0:45)',
                            style: AppTextStyles.labelMd
                                .copyWith(color: AppColors.primaryContainer)),
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
}
