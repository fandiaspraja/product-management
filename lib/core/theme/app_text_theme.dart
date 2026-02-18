import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labamu/core/theme/app_colors.dart';

class AppTextTheme {
  static TextTheme light = TextTheme(
    headlineMedium: GoogleFonts.urbanist(
      fontSize: 23,
      fontWeight: FontWeight.w900,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.urbanist(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.urbanist(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
    labelMedium: GoogleFonts.urbanist(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
  );

  static TextTheme dark = TextTheme(
    headlineMedium: GoogleFonts.urbanist(
      fontSize: 23,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.urbanist(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.urbanist(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.urbanist(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textTertiary,
    ),
  );
}
