import 'package:flutter/material.dart';

/// Semua warna dikumpulkan di sini supaya gampang diubah dari satu tempat.
class AppColors {
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF1A1A1A);
  static const surfaceLight = Color(0xFF262626);
  static const white = Colors.white;
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFA0A0A0);
  static const border = Color(0xFF2E2E2E);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.white,
        surface: AppColors.surface,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 15),
        bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
      useMaterial3: true,
    );
  }
}
