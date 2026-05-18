import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color coffeeBrown = Color(0xFF4A2C2A);
  static const Color coffeeBrownDark = Color(0xFF2F1B19);
  static const Color cream = Color(0xFFD4A373);
  static const Color warmOrange = Color(0xFFE76F51);
  static const Color lightBackground = Color(0xFFFBF8F3);
  static const Color darkBackground = Color(0xFF181412);
  static const Color lightSurface = Color(0xFFFFFCF7);
  static const Color darkSurface = Color(0xFF241D1A);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: coffeeBrown,
      brightness: Brightness.light,
      primary: coffeeBrown,
      secondary: cream,
      tertiary: warmOrange,
      surface: lightSurface,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      textTheme: _textTheme(Brightness.light),
      cardTheme: _cardTheme(colorScheme.surface),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: coffeeBrown,
      brightness: Brightness.dark,
      primary: cream,
      secondary: warmOrange,
      tertiary: const Color(0xFFF4A261),
      surface: darkSurface,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: coffeeBrownDark,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      textTheme: _textTheme(Brightness.dark),
      cardTheme: _cardTheme(colorScheme.surface),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final textColor = brightness == Brightness.dark
        ? const Color(0xFFF6EFE7)
        : coffeeBrown;
    final mutedColor = brightness == Brightness.dark
        ? const Color(0xFFCFC2B8)
        : const Color(0xFF6F5B56);

    return TextTheme(
      headlineLarge: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      bodyLarge: TextStyle(color: textColor, fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(color: mutedColor, fontSize: 14, height: 1.45),
      labelLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        color: mutedColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }

  static CardThemeData _cardTheme(Color surfaceColor) {
    return CardThemeData(
      color: surfaceColor,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.surfaceContainerHighest,
        disabledForegroundColor: colorScheme.onSurfaceVariant,
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }
}
