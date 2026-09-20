import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Display & Headings (Space Grotesk)
  static final TextStyle displayLg = GoogleFonts.spaceGrotesk(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 52 / 48,
    letterSpacing: -0.04 * 48,
  );

  static final TextStyle headlineLg = GoogleFonts.spaceGrotesk(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 40 / 36,
    letterSpacing: -0.03 * 36,
  );

  static final TextStyle headlineLgMobile = GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 32 / 28,
    letterSpacing: -0.02 * 28,
  );

  static final TextStyle headlineMd = GoogleFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 28 / 24,
    letterSpacing: -0.02 * 24,
  );

  static final TextStyle headlineSm = GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 24 / 20,
    letterSpacing: -0.01 * 20,
  );

  static final TextStyle titleMd = GoogleFonts.spaceGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
  );

  // Body (Inter)
  static final TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static final TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );

  static final TextStyle bodySm = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.01 * 12,
  );

  // Labels (Space Grotesk - Used heavily for CTAs and HUDs)
  static final TextStyle labelLg = GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 18 / 14,
    letterSpacing: 0.05 * 14,
  );

  static final TextStyle labelMd = GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0.06 * 12,
  );

  static final TextStyle labelSm = GoogleFonts.spaceGrotesk(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 12 / 10,
    letterSpacing: 0.08 * 10,
  );

  // Numeric Stats (Prize pools, balances)
  static final TextStyle statNumeric = GoogleFonts.spaceGrotesk(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 36 / 32,
    letterSpacing: -0.02 * 32,
  );
}
