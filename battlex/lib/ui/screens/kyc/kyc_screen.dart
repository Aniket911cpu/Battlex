import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import '../../components/cyber_grid_bg.dart';
import '../../components/glass_container.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CyberGridBg(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Identity Verification', style: AppTextStyles.headlineLg.copyWith(color: AppColors.onSurface)),
                    const SizedBox(height: 8),
                    Text('Required to withdraw cash winnings to your bank.', style: AppTextStyles.bodyMd.copyWith(color: AppColors.secondary)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildKycStep(
                      title: 'Aadhaar Card',
                      subtitle: 'Verify your national ID',
                      icon: Icons.badge,
                      status: 'PENDING',
                      statusColor: AppColors.tertiaryContainer,
                    ),
                    const SizedBox(height: 16),
                    _buildKycStep(
                      title: 'PAN Card',
                      subtitle: 'Required for TDS & Tax compliance',
                      icon: Icons.credit_card,
                      status: 'REQUIRED',
                      statusColor: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    _buildKycStep(
                      title: 'Selfie Verification',
                      subtitle: 'Match face with documents',
                      icon: Icons.face,
                      status: 'REQUIRED',
                      statusColor: AppColors.error,
                    ),
                    
                    const SizedBox(height: 32),
                    GlassContainer(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.shield, color: AppColors.successGreen, size: 32),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('100% SECURE & ENCRYPTED', style: AppTextStyles.labelSm.copyWith(color: AppColors.successGreen)),
                                const SizedBox(height: 4),
                                Text('Your data is strictly used for verification and never shared.', style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: PrimaryButton(
                  text: 'START VERIFICATION',
                  icon: Icons.camera_alt,
                  onPressed: () {
                    // Start KYC flow
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKycStep({
    required String title,
    required String subtitle,
    required IconData icon,
    required String status,
    required Color statusColor,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryContainer),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Text(status, style: AppTextStyles.labelSm.copyWith(color: statusColor)),
          ),
        ],
      ),
    );
  }
}
