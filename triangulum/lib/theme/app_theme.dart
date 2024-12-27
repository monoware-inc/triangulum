import 'package:flutter/material.dart';

class AppTheme {
  static const _fontFamily = 'RussoOne';

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: _fontFamily, fontSize: 48),
        displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 32),
        displaySmall: TextStyle(fontFamily: _fontFamily, fontSize: 24),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 18),
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 16),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: _fontFamily, fontSize: 48),
        displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 32),
        displaySmall: TextStyle(fontFamily: _fontFamily, fontSize: 24),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 18),
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 16),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
} 