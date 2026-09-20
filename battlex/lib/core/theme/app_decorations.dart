import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  static BoxDecoration glassContainer = BoxDecoration(
    color: const Color(0xFF141416).withOpacity(0.9),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white.withOpacity(0.08)),
  );

  static BoxDecoration glassContainerActive = BoxDecoration(
    color: const Color(0xFF141416).withOpacity(0.9),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.primaryGlow.withOpacity(0.2)),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryGlow.withOpacity(0.35),
        blurRadius: 24,
      ),
    ],
  );

  static BoxDecoration buttonGlow = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryGlow.withOpacity(0.45),
        blurRadius: 18,
      ),
    ],
  );
}
