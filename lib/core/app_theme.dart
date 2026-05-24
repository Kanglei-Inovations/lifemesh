import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.deepNavy,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.neonPurple,
      secondary: AppColors.cyanBlue,
      surface: AppColors.deepNavy,
      onSurface: AppColors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.white.withValues(alpha: 0.9),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ).copyWith(
        elevation: WidgetStateProperty.all(0),
      ),
    ),
  );
}
