import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Kid-Friendly Color Palette
  static const Color primaryOrange = Color(0xFFFF9F1C); // Bright Orange
  static const Color primaryYellow = Color(0xFFFFD93D); // Sunny Yellow
  static const Color skyBlue = Color(0xFF4CC9F0); // Friendly Blue
  static const Color accentPink = Color(0xFFFF6B6B); // Playful Pink
  static const Color freshGreen = Color(0xFF2EC4B6); // Fresh Green

  static const Color backgroundCream = Color(0xFFFFFDF7); // Warm White
  static const Color surfaceWhite = Colors.white;

  // Text Colors
  static const Color textDark = Color(0xFF2D3436); // Softer Black
  static const Color textGrey = Color(0xFF535c68);

  // Legacy mappings for backward compatibility (mapped to new theme)
  static const Color primaryBlue = skyBlue;
  static const Color primarySky = skyBlue;
  // primaryOrange is already defined above

  static const Color attentionOrange = primaryOrange;
  static const Color attentionOrangeLight = Color(
    0xFFFFF4E6,
  ); // Light orange tint

  static const Color impulsivitySky = skyBlue;
  static const Color impulsivitySkyLight = Color(0xFFE0F7FA); // Light blue tint

  static const Color successGreen = freshGreen;
  static const Color errorRed =
      accentPink; // Use pink for errors in kid theme? or standard red? pure red is too harsh.
  // Actually, let's keep errorRed slightly standard but soft, or use accentPink. accentPink is better for 'kid friendly'.

  // Slate mappings - mapping to softer greys and text colors
  static const Color slateLight = backgroundCream;
  static const Color slate100 = Color(0xFFF5F5F5);
  static const Color slate200 = Color(0xFFE0E0E0); // Softer border color
  static const Color slate400 = Color(0xFFB0B0B0); // Disabled/Hint
  static const Color slate500 = textGrey;
  static const Color slate600 = textGrey;
  static const Color slate700 = textDark;
  static const Color slate800 = textDark;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto', // Fallback to system font, but styled softly
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        primary: primaryOrange,
        secondary: skyBlue,
        tertiary: accentPink,
        surface: surfaceWhite,
        brightness: Brightness.light,
        background: backgroundCream,
      ),
      scaffoldBackgroundColor: backgroundCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 24,
          fontWeight: FontWeight.w800, // Bolder, chunkier title
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: textDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          elevation: 4,
          shadowColor: primaryOrange.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Pill shape
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Super rounded
          side: const BorderSide(color: Color(0xFFF0F0F0), width: 2),
        ),
      ),
      iconTheme: const IconThemeData(color: primaryOrange, size: 28),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: textDark,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: textDark,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textGrey,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textDark,
          height: 1.5,
        ),
        bodyMedium: TextStyle(fontSize: 16, color: textGrey, height: 1.5),
        bodySmall: TextStyle(fontSize: 14, color: Color(0xFF95A5A6)),
      ),
    );
  }
}
