import 'package:flutter/material.dart';

/// Material Design 3 theme configuration for myNET Mobile
class AppTheme {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2); // Material Blue 700
  static const Color primaryLight = Color(0xFF63A4FF);
  static const Color primaryDark = Color(0xFF004BA0);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary Colors
  static const Color secondary = Color(0xFF4CAF50); // Material Green 500
  static const Color secondaryLight = Color(0xFF80E27E);
  static const Color secondaryDark = Color(0xFF087F23);
  static const Color onSecondary = Color(0xFF000000);

  // Surface Colors
  static const Color surface = Color(0xFFFAFAFA); // Light Grey 50
  static const Color surfaceVariant = Color(0xFFE0E0E0); // Grey 300
  static const Color background = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF212121);

  // Outline Colors
  static const Color outline = Color(0xFFBDBDBD); // Grey 400
  static const Color outlineVariant = Color(0xFFE0E0E0); // Grey 300

  // Semantic Colors
  static const Color error = Color(0xFFD32F2F); // Material Red 700
  static const Color errorLight = Color(0xFFEF5350);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFF57C00); // Orange 700
  static const Color success = Color(0xFF388E3C); // Green 700
  static const Color info = Color(0xFF1976D2); // Blue 700

  // Spacing (8dp grid)
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 24.0;
  static const double space6 = 32.0;
  static const double space7 = 48.0;
  static const double space8 = 64.0;

  // Corner Radius
  static const double radiusExtraSmall = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 28.0;

  // Component Sizes
  static const double touchTargetSize = 48.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 40.0;
  static const double avatarLargeSize = 56.0;
  static const double fabSize = 56.0;

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryLight,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryLight,
        surface: surface,
        onSurface: onBackground,
        surfaceContainerHighest: surfaceVariant,
        background: background,
        onBackground: onBackground,
        error: error,
        onError: onError,
        outline: outline,
        outlineVariant: outlineVariant,
      ),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        backgroundColor: background,
        foregroundColor: onBackground,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: onBackground,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: space4, vertical: space2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: primary,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusExtraLarge),
          side: const BorderSide(color: outline),
        ),
        padding: const EdgeInsets.symmetric(horizontal: space4),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondary,
        foregroundColor: onSecondary,
        elevation: 2,
        focusElevation: 3,
        hoverElevation: 3,
        highlightElevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusExtraLarge)),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space4,
          vertical: space4,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 5,
        modalElevation: 5,
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLarge),
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF90CAF9), // Blue 200
        onPrimary: Color(0xFF003258),
        secondary: Color(0xFF81C784), // Green 300
        onSecondary: Color(0xFF00330E),
        surface: Color(0xFF1C1B1F),
        onSurface: Color(0xFFE6E1E5),
        background: Color(0xFF1C1B1F),
        onBackground: Color(0xFFE6E1E5),
        error: Color(0xFFEF5350),
        onError: Color(0xFF000000),
      ),
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFFE6E1E5),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: space4, vertical: space2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1C1B1F),
        selectedColor: const Color(0xFF90CAF9),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusExtraLarge),
          side: const BorderSide(color: Color(0xFFE6E1E5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: space4),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF81C784),
        foregroundColor: Color(0xFF00330E),
        elevation: 2,
        focusElevation: 3,
        hoverElevation: 3,
        highlightElevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusExtraLarge)),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1C1B1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: Color(0xFF90CAF9), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space4,
          vertical: space4,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 5,
        modalElevation: 5,
        backgroundColor: Color(0xFF1C1B1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLarge),
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE6E1E5),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
