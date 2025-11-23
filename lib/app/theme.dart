import 'package:flutter/material.dart';

// Define your brand colors
const Color brandColor = Color(0xFF2B7A9B);
const Color accentColor = Color(0xFFE8956B);

ThemeData wanderBooksTheme() {
  return ThemeData(
    // Primary color scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: brandColor,
      primary: brandColor,
      secondary: accentColor,
      brightness: Brightness.light,
    ),

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: brandColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // Elevated Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: brandColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: brandColor,
      ),
    ),

    // Outlined Buttons
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: brandColor,
        side: BorderSide(color: brandColor, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),

    // Input Decoration (TextFormField)
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: brandColor, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey[700]),
      floatingLabelStyle: TextStyle(color: brandColor),
    ),

    // Card
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Icon theme
    iconTheme: IconThemeData(
      color: brandColor,
    ),

    // Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: brandColor,
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: brandColor.withOpacity(0.1),
      labelStyle: TextStyle(color: brandColor),
      secondaryLabelStyle: TextStyle(color: Colors.white),
      selectedColor: brandColor,
      checkmarkColor: Colors.white,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: brandColor,
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    // Tab Bar
    tabBarTheme: TabBarThemeData(
      labelColor: brandColor,
      unselectedLabelColor: Colors.grey[600],
      indicatorColor: accentColor,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 1,
    ),

    // Use system font with good readability
    fontFamily: 'System',

    // Text theme
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.grey[900],
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.grey[900],
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.grey[900],
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.grey[800],
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.grey[800],
      ),
    ),
  );
}
