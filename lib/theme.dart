import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFD2B48C); // Tan
  static const Color secondaryColor = Color(0xFFF5DEB3); // Wheat
  static const Color backgroundColor = Color(0xFFFFFAF0); // Floral White
  static const Color textColor = Color(0xFF4A4A4A); // Dark Gray
  static const Color cardColor = Color(0xFFFFF5EE); // Seashell
  static const Color appBarColor = Color(0xFF2F4F4F); // Dark Slate Gray
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: 'ArabicFont',
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        background: AppColors.backgroundColor,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: AppColors.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}