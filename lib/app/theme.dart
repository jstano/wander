import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData createTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  // ── WanderBooks Travel-Inspired Colors ────────────
  // Primary: Wanderlust Teal - evokes ocean, sky, exploration
  final primary = const Color(0xFF0891B2); // Cyan-600
  final primaryLight = const Color(0xFF06B6D4); // Cyan-500
  final primaryDark = const Color(0xFF0E7490); // Cyan-700

  // Secondary: Adventure Orange - sunset, warmth, excitement
  final secondary = const Color(0xFFF97316); // Orange-500
  final secondaryLight = const Color(0xFFFB923C); // Orange-400

  // Accent: Nature Green - growth, adventure, outdoor
  final accent = const Color(0xFF10B981); // Emerald-500

  // Functional Colors
  final success = const Color(0xFF10B981); // Emerald-500
  final warning = const Color(0xFFF59E0B); // Amber-500
  final error = const Color(0xFFEF4444); // Red-500
  final info = primary;

  // Neutral Colors - softer for travel imagery
  final textPrimary = isDark
      ? const Color(0xFFF9FAFB) // Gray-50
      : const Color(0xFF111827); // Gray-900
  final textSecondary = isDark
      ? const Color(0xFFD1D5DB) // Gray-300
      : const Color(0xFF6B7280); // Gray-500
  final textTertiary = isDark
      ? const Color(0xFF9CA3AF) // Gray-400
      : const Color(0xFF9CA3AF); // Gray-400
  final disabled = isDark
      ? const Color(0xFF4B5563) // Gray-600
      : const Color(0xFFD1D5DB); // Gray-300

  final surface = isDark ? const Color(0xFF1F2937) : Colors.white; // Gray-800
  final background = isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB); // Gray-900/50
  final surfaceVariant = isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6); // Gray-700/100
  final border = isDark
      ? const Color(0xFF4B5563) // Gray-600
      : const Color(0xFFE5E7EB); // Gray-200

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,

    // ── Color Scheme ──────────────────────────────────
    primaryColor: primary,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      tertiary: accent,
      onTertiary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      background: background,
      onBackground: textPrimary,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: textSecondary,
    ),

    // ── AppBar (Transparent for hero images) ──────────
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: textPrimary),
      actionsIconTheme: IconThemeData(color: textSecondary),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: background,
      ),
    ),

    // ── Elevated Button (Primary CTA - Book Now, Save, etc) ─
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size(0, 48), // Larger for easier tapping
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Friendly, modern
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.3,
        ),
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disabled;
          }
          if (states.contains(MaterialState.pressed)) {
            return primaryDark;
          }
          if (states.contains(MaterialState.hovered)) {
            return primaryLight;
          }
          return primary;
        }),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) return 0;
          if (states.contains(MaterialState.hovered)) return 4;
          return 2;
        }),
        shadowColor: MaterialStateProperty.all(
          primary.withValues(alpha: 0.3),
        ),
      ),
    ),

    // ── Outlined Button (Secondary actions) ───────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(color: primary, width: 2),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.3,
        ),
      ).copyWith(
        foregroundColor: MaterialStateProperty.all(primary),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return primary.withValues(alpha: 0.1);
          }
          if (states.contains(MaterialState.hovered)) {
            return primary.withValues(alpha: 0.05);
          }
          return Colors.transparent;
        }),
      ),
    ),

    // ── Text Button (Tertiary actions) ────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ).copyWith(
        foregroundColor: MaterialStateProperty.all(primary),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return primary.withValues(alpha: 0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return primary.withValues(alpha: 0.08);
          }
          return Colors.transparent;
        }),
      ),
    ),

    // ── Input Fields (Search, Forms) ──────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? surfaceVariant : const Color(0xFFFAFAFA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: disabled, width: 1),
      ),
      hintStyle: GoogleFonts.inter(
        color: textTertiary,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 15,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        color: primary,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
    ),

    // ── Card Color (Destination cards, hotel cards) ───
    cardColor: surface,

    // ── Dialog Background ─────────────────────────────
    dialogBackgroundColor: surface,

    // ── Divider ───────────────────────────────────────
    dividerTheme: DividerThemeData(
      color: border,
      thickness: 1,
      space: 1,
    ),

    // ── Switches ──────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return Colors.white;
        return const Color(0xFFF3F4F6);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return disabled;
        }
        if (states.contains(MaterialState.selected)) {
          return primary;
        }
        return border;
      }),
    ),

    // ── Checkbox ──────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: BorderSide(color: border, width: 2),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return primary;
        return Colors.transparent;
      }),
    ),

    // ── Radio ─────────────────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return primary;
        return border;
      }),
    ),

    // ── Snackbar (Notifications) ──────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: isDark
          ? const Color(0xFF374151)
          : const Color(0xFF1F2937),
      contentTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
      actionTextColor: secondaryLight,
    ),

    // ── Bottom Sheet ──────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      elevation: 8,
      modalBackgroundColor: surface,
      modalElevation: 8,
    ),

    // ── Typography (Travel-Friendly) ──────────────────
    fontFamily: 'Inter',
    textTheme: TextTheme(
      // Large Headings (Destination names, Hero text)
      displayLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 40,
        height: 1.2,
        letterSpacing: -1,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.25,
        letterSpacing: -0.5,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        height: 1.3,
        color: textPrimary,
      ),

      // Headlines (Section titles, Card headers)
      headlineLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.3,
        letterSpacing: -0.5,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        height: 1.4,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        height: 1.4,
        color: textPrimary,
      ),

      // Titles (List items, Card titles)
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        height: 1.4,
        letterSpacing: -0.2,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
        color: textPrimary,
      ),
      titleSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.5,
        color: textPrimary,
      ),

      // Body (Descriptions, Content)
      bodyLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.6,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.6,
        color: textSecondary,
      ),
      bodySmall: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.5,
        color: textTertiary,
      ),

      // Labels (Buttons, Tags, Metadata)
      labelLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.4,
        letterSpacing: 0.5,
        color: textPrimary,
      ),
      labelMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.4,
        letterSpacing: 0.5,
        color: textSecondary,
      ),
      labelSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.4,
        letterSpacing: 0.5,
        color: textTertiary,
      ),
    ),

    // ── List Tiles (Itinerary items, Settings) ────────
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: Colors.transparent,
      selectedTileColor: primary.withValues(alpha: 0.1),
      iconColor: textSecondary,
      textColor: textPrimary,
    ),

    // ── Chips (Tags: Beach, Adventure, Budget, etc) ───
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariant,
      deleteIconColor: textSecondary,
      disabledColor: disabled,
      selectedColor: primary.withValues(alpha: 0.15),
      secondarySelectedColor: secondary.withValues(alpha: 0.15),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      brightness: brightness,
      elevation: 0,
      pressElevation: 0,
    ),

    // ── Tooltips ──────────────────────────────────────
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF374151)
            : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // ── Progress Indicator (Loading states) ───────────
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primary,
      linearTrackColor: border,
      circularTrackColor: border,
    ),

    // ── Slider (Price range, Rating filter) ───────────
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: border,
      thumbColor: primary,
      overlayColor: primary.withValues(alpha: 0.2),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),

    // ── Tab Indicators ────────────────────────────────
    indicatorColor: primary,
    unselectedWidgetColor: textTertiary,

    // ── Navigation Rail ───────────────────────────────
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: surface,
      selectedIconTheme: IconThemeData(color: primary, size: 28),
      unselectedIconTheme: IconThemeData(color: textSecondary, size: 24),
      selectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        color: textSecondary,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
    ),

    // ── Bottom Navigation Bar ─────────────────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textTertiary,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),

    // ── FAB (Quick actions: Add trip, Book) ───────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondary,
      foregroundColor: Colors.white,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // ── Icon Theme ────────────────────────────────────
    iconTheme: IconThemeData(
      color: textSecondary,
      size: 24,
    ),
    primaryIconTheme: IconThemeData(
      color: primary,
      size: 24,
    ),

    // ── Interactions ──────────────────────────────────
    splashFactory: InkRipple.splashFactory,
    highlightColor: primary.withValues(alpha: 0.1),
    hoverColor: primary.withValues(alpha: 0.05),
    focusColor: primary.withValues(alpha: 0.12),
    splashColor: primary.withValues(alpha: 0.15),

    // ── Platform Adaptive Density ─────────────────────
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

// ═══════════════════════════════════════════════════════
// Helper Widget: Travel Card (for destinations, hotels)
// ═══════════════════════════════════════════════════════
class TravelCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final String? imageUrl;

  const TravelCard({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Helper Widget: Gradient Overlay for Hero Images
// ═══════════════════════════════════════════════════════
class GradientOverlay extends StatelessWidget {
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientOverlay({
    Key? key,
    required this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
