import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData createTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  // ── Ant Design 5 Default Colors ──────────────────
  // Primary: Daybreak Blue #1677ff (6th color in blue palette)
  final primary = const Color(0xFF1677FF);
  final primaryLight = const Color(0xFF4096FF);
  final primaryDark = const Color(0xFF0958D9);

  // Functional Colors
  final success = const Color(0xFF52C41A);
  final warning = const Color(0xFFFAAD14);
  final error = const Color(0xFFFF4D4F);
  final info = primary; // Info follows brand color in Ant Design

  // Neutral Colors (based on Ant Design's neutral palette)
  final textPrimary = isDark
      ? const Color(0xFFFFFFFF).withValues(alpha: 0.85)
      : const Color(0xFF000000).withValues(alpha: 0.85);
  final textSecondary = isDark
      ? const Color(0xFFFFFFFF).withValues(alpha: 0.65)
      : const Color(0xFF000000).withValues(alpha: 0.65);
  final textTertiary = isDark
      ? const Color(0xFFFFFFFF).withValues(alpha: 0.45)
      : const Color(0xFF000000).withValues(alpha: 0.45);
  final disabled = isDark
      ? const Color(0xFFFFFFFF).withValues(alpha: 0.25)
      : const Color(0xFF000000).withValues(alpha: 0.25);

  final surface = isDark ? const Color(0xFF141414) : Colors.white;
  final background = isDark ? const Color(0xFF000000) : const Color(0xFFFAFAFA);
  final border = isDark
      ? const Color(0xFFFFFFFF).withValues(alpha: 0.12)
      : const Color(0xFF000000).withValues(alpha: 0.06);

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,

    // ── Color Scheme ──────────────────────────────────
    primaryColor: primary,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: primary,
      onSecondary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      // background: background,
      // onBackground: textPrimary,
      surfaceContainerHighest: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F5F5),
      // surfaceVariant: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F5F5),
      onSurfaceVariant: textSecondary,
    ),

    // ── AppBar ────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      centerTitle: false, // Ant Design aligns left by default
      titleTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        height: 1.5,
      ),
      iconTheme: IconThemeData(color: textSecondary),
      actionsIconTheme: IconThemeData(color: textSecondary),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: background,
      ),
    ),

    // ── Elevated Button (Ant Design Primary Button) ───
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        minimumSize: const Size(0, 32), // Ant Design default height: 32px
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // border-radius-base: 6px in v5
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.5714,
        ),
        shadowColor: Colors.transparent,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark
                ? const Color(0xFFFFFFFF).withValues(alpha: 0.08)
                : const Color(0xFF000000).withValues(alpha: 0.04);
          }
          if (states.contains(WidgetState.pressed)) {
            return primaryDark;
          }
          if (states.contains(WidgetState.hovered)) {
            return primaryLight;
          }
          return primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabled;
          }
          return Colors.white;
        }),
      ),
    ),

    // ── Outlined Button (Ant Design Default Button) ───
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        minimumSize: const Size(0, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: BorderSide(color: border, width: 1),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.5714,
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark
                ? const Color(0xFFFFFFFF).withValues(alpha: 0.04)
                : const Color(0xFF000000).withValues(alpha: 0.04);
          }
          if (states.contains(WidgetState.pressed)) {
            return isDark
                ? const Color(0xFFFFFFFF).withValues(alpha: 0.08)
                : const Color(0xFF000000).withValues(alpha: 0.02);
          }
          if (states.contains(WidgetState.hovered)) {
            return isDark
                ? const Color(0xFFFFFFFF).withValues(alpha: 0.06)
                : const Color(0xFF000000).withValues(alpha: 0.06);
          }
          return surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabled;
          }
          return textPrimary;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: border, width: 1);
          }
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: primary, width: 1);
          }
          return BorderSide(color: border, width: 1);
        }),
      ),
    ),

    // ── Text Button (Ant Design Text/Link Button) ─────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
        minimumSize: const Size(0, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.5714,
        ),
      ).copyWith(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabled;
          }
          return primary;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return primary.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return isDark
                ? const Color(0xFFFFFFFF).withValues(alpha: 0.06)
                : const Color(0xFF000000).withValues(alpha: 0.06);
          }
          return Colors.transparent;
        }),
      ),
    ),

    // ── Input Fields ──────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark
          ? const Color(0xFFFFFFFF).withValues(alpha: 0.04)
          : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: primary, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: error, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: border, width: 1),
      ),
      hintStyle: TextStyle(
        color: textTertiary,
        fontSize: 14,
        height: 1.5714,
      ),
      labelStyle: TextStyle(
        color: textSecondary,
        fontSize: 14,
        height: 1.5714,
      ),
      floatingLabelStyle: TextStyle(
        color: primary,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
    ),

    // ── Card Color (Cards don't have a theme in newer Flutter) ─
    cardColor: surface,

    // ── Divider ───────────────────────────────────────
    dividerTheme: DividerThemeData(
      color: border,
      thickness: 1,
      space: 1,
    ),

    // ── Switches ──────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return isDark
              ? const Color(0xFFFFFFFF).withValues(alpha: 0.12)
              : const Color(0xFF000000).withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return isDark
            ? const Color(0xFFFFFFFF).withValues(alpha: 0.3)
            : const Color(0xFF000000).withValues(alpha: 0.25);
      }),
    ),

    // ── Checkbox ──────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      side: BorderSide(color: border, width: 1),
    ),

    // ── Radio ─────────────────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return border;
      }),
    ),

    // ── Dialog Color (Dialogs don't have a theme in newer Flutter) ─
    dialogTheme: DialogThemeData(
      backgroundColor: surface
    ),

    // ── Snackbar ──────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: isDark
          ? const Color(0xFF434343)
          : const Color(0xFF2C2C2C),
      contentTextStyle: GoogleFonts.inter(
        color: Colors.white.withValues(alpha: 0.85),
        fontSize: 14,
        height: 1.5714,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    ),

    // ── Bottom Sheet ──────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      elevation: 0,
    ),

    // ── Typography (Ant Design defaults) ──────────────
    fontFamily: 'Inter',
    textTheme: TextTheme(
      // Display styles (not commonly used in Ant Design)
      displayLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 38,
        height: 1.23,
      ),
      displayMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 30,
        height: 1.35,
      ),
      displaySmall: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.35,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.35,
      ),
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        height: 1.4,
      ),
      headlineSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
      ),

      // Title styles
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.5714,
      ),
      titleSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.5714,
      ),

      // Body styles (most common in Ant Design)
      bodyLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5714,
      ),
      bodyMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14, // Default font size in Ant Design
        height: 1.5714,
      ),
      bodySmall: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.66,
      ),

      // Label styles
      labelLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.5714,
      ),
      labelMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.66,
      ),
      labelSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.66,
      ),
    ),

    // ── List Tiles ────────────────────────────────────
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      dense: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),

    // ── Chips ─────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: isDark
          ? const Color(0xFFFFFFFF).withValues(alpha: 0.08)
          : const Color(0xFF000000).withValues(alpha: 0.06),
      deleteIconColor: textSecondary,
      disabledColor: disabled,
      selectedColor: primary.withValues(alpha: 0.1),
      secondarySelectedColor: primary.withValues(alpha: 0.1),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: border, width: 1),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5714,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5714,
      ),
      brightness: brightness,
    ),

    // ── Tooltips ──────────────────────────────────────
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF434343)
            : const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: GoogleFonts.inter(
        color: Colors.white.withValues(alpha: 0.85),
        fontSize: 14,
        height: 1.5714,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    ),

    // ── Progress Indicator ────────────────────────────
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primary,
      linearTrackColor: isDark
          ? const Color(0xFFFFFFFF).withValues(alpha: 0.12)
          : const Color(0xFF000000).withValues(alpha: 0.06),
      circularTrackColor: isDark
          ? const Color(0xFFFFFFFF).withValues(alpha: 0.12)
          : const Color(0xFF000000).withValues(alpha: 0.06),
    ),

    // ── Slider ────────────────────────────────────────
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: isDark
          ? const Color(0xFFFFFFFF).withValues(alpha: 0.12)
          : const Color(0xFF000000).withValues(alpha: 0.06),
      thumbColor: primary,
      overlayColor: primary.withValues(alpha: 0.12),
      trackHeight: 4,
    ),

    // ── Tab Bar (Use indicatorColor and labelColor instead) ──
    tabBarTheme: TabBarThemeData(
      indicatorColor: primary,
    ),
    unselectedWidgetColor: textSecondary,

    // ── Navigation Rail ───────────────────────────────
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: surface,
      selectedIconTheme: IconThemeData(color: primary),
      unselectedIconTheme: IconThemeData(color: textSecondary),
      selectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 14,
        color: primary,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 14,
        color: textSecondary,
      ),
    ),

    // ── Bottom Navigation Bar ─────────────────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    // ── FAB ───────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),

    // ── Icon Theme ────────────────────────────────────
    iconTheme: IconThemeData(
      color: textSecondary,
      size: 24,
    ),

    // ── Interactions ──────────────────────────────────
    splashFactory: InkRipple.splashFactory,
    highlightColor: primary.withValues(alpha: 0.08),
    hoverColor: isDark
        ? const Color(0xFFFFFFFF).withValues(alpha: 0.06)
        : const Color(0xFF000000).withValues(alpha: 0.06),
    focusColor: primary.withValues(alpha: 0.12),

    // ── Platform Adaptive Density ─────────────────────
    visualDensity: VisualDensity.standard,
  );
}
