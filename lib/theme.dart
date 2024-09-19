import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.teal;
  static const Color secondaryColor = Colors.amber;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;
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
    );
  }
}