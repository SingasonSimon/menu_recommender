
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Premium Palette
  static const Color background = Color(0xFF1E1E1E); // Dark Charcoal
  static const Color cardSurface = Color(0xFF2C2C2C); // Slightly lighter charcoal
  static const Color cream = Color(0xFFF5F5DC); // Cream text
  static const Color accentOrange = Color(0xFFFF7043); // Burnt Orange
  static const Color accentGreen = Color(0xFF66BB6A); // Fresh Green
  static const Color greyText = Color(0xFFBDBDBD);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accentOrange,
      cardColor: AppColors.cardSurface,
      
      // Creating a color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentOrange,
        secondary: AppColors.accentGreen,
        surface: AppColors.background, // Background color acts as surface in M3 sometimes or use cardSurface
        onSurface: AppColors.cream,
      ),

      // Text Theme with Google Fonts
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.cream,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.cream,
        ),
        titleLarge: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.cream,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          color: AppColors.greyText,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 14,
          color: AppColors.cream,
        ),
      ),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.cream,
        ),
        iconTheme: const IconThemeData(color: AppColors.cream),
      ),
      
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias, // Smooth edges for images
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentOrange,
        foregroundColor: Colors.white,
      ),
    );
  }
}
