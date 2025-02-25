import 'package:flutter/material.dart';

class AppTheme {
  static const _fontFamily = 'RussoOne';

  // Custom Colors
  static const _primaryBackground = Color(0xFFF4F4F4);
  static const _secondaryBackground = Color(0xFFFFFFFF);
  static const _primaryText = Color(0xFF333333);
  static const _secondaryText = Color(0xFF777777);
  static const _accentColor = Color(0xFF007AFF);
  static const _successColor = Color(0xFF28A745);
  static const _errorColor = Color(0xFFDC3545);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        surface: _primaryBackground,
        surfaceContainer: _secondaryBackground,
        primary: _accentColor,
        onPrimary: _secondaryBackground,
        secondary: _accentColor,
        onSecondary: _secondaryBackground,
        error: _errorColor,
        onError: _secondaryBackground,
        surfaceContainerHighest: _primaryBackground,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          color: _primaryText,
          fontFamily: _fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          color: _primaryText,
          fontFamily: _fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          color: _primaryText,
          fontFamily: _fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: _primaryText,
          fontFamily: _fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: _primaryText,
          fontFamily: _fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: _secondaryText,
          fontFamily: _fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          color: _secondaryText,
          fontFamily: _fontFamily,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: _secondaryBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _accentColor,
          foregroundColor: _secondaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
          ),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: _primaryText,
        size: 24,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _accentColor,
      ),

      // Scaffold Background Color
      scaffoldBackgroundColor: _primaryBackground,
    );
  }

  static ThemeData get darkTheme {
    // Dark Theme Colors
    const darkPrimaryBackground = Color(0xFF121212);
    const darkSecondaryBackground = Color(0xFF1E1E1E);
    const darkPrimaryText = Color(0xFFFFFFFF);
    const darkSecondaryText = Color(0xFFA0A0A0);
    const darkAccentColor = Color(0xFF03A9F4);
    const darkSuccessColor = Color(0xFF4CAF50);
    const darkErrorColor = Color(0xFFF44336);

    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        surface: darkPrimaryBackground,
        surfaceContainer: darkSecondaryBackground,
        primary: darkAccentColor,
        onPrimary: darkPrimaryText,
        secondary: darkAccentColor,
        onSecondary: darkPrimaryText,
        error: darkErrorColor,
        onError: darkPrimaryText,
        onSurface: darkPrimaryText,
        surfaceContainerHighest: darkSecondaryBackground,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          color: darkPrimaryText,
          fontFamily: _fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          color: darkPrimaryText,
          fontFamily: _fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          color: darkPrimaryText,
          fontFamily: _fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: darkPrimaryText,
          fontFamily: _fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: darkPrimaryText,
          fontFamily: _fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: darkSecondaryText,
          fontFamily: _fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          color: darkSecondaryText,
          fontFamily: _fontFamily,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: darkSecondaryBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkAccentColor,
          foregroundColor: darkPrimaryText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
          ),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: darkPrimaryText,
        size: 24,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: darkAccentColor,
      ),

      // Scaffold Background Color
      scaffoldBackgroundColor: darkPrimaryBackground,
    );
  }

  // Success and Error Colors for status indicators
  static Color get successColor => _successColor;
  static Color get errorColor => _errorColor;
  static Color get secondaryText => _secondaryText;
} 