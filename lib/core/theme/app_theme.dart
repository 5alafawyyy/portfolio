import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color mochaMousse = Color(0xFFB7986B); // 17-1230 Mocha Mousse
  static const Color darkBackground = Color(0xFF2C2113); // Deep brown
  static const Color darkSurface = Color(0xFF3E2F1C); // Lighter brown
  static const Color darkOnBackground = Color(0xFFF5EFE7); // Light for contrast
  static const Color neutralIcon = Color(
    0xFF8D7960,
  ); // Neutral brown/grey for unselected

  // Form specific colors
  static const Color formBackground = Color(0xFFF5EFE7);
  static const Color formBorder = Color(0xFFE6DCC2);
  static const Color formIconBackground = Color(0xFFF0E8D9);

  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primaryColor: mochaMousse,
    splashColor: mochaMousse.withValues(alpha: 0.18),
    highlightColor: mochaMousse.withValues(alpha: 0.10),
    hoverColor: mochaMousse.withValues(alpha: 0.08),
    // ignore: deprecated_member_use
    primarySwatch: MaterialColor(mochaMousse.value, <int, Color>{
      50: Color(0xFFF5EFE7),
      100: Color(0xFFE6DCC2),
      200: Color(0xFFD6C89C),
      300: Color(0xFFC6B576),
      400: Color(0xFFB7986B), // main
      500: Color(0xFFB7986B),
      600: Color(0xFF9C7C4B),
      700: Color(0xFF7A613A),
      800: Color(0xFF594729),
      900: Color(0xFF372C18),
    }),
    colorScheme: ColorScheme.light(
      primary: mochaMousse,
      secondary: mochaMousse,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: formBackground,
      prefixIconColor: mochaMousse,
      labelStyle: GoogleFonts.poppins(color: mochaMousse),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: formBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: formBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: mochaMousse, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade400, width: 2),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: mochaMousse),
      selectedLabelTextStyle: GoogleFonts.poppins(
        color: mochaMousse,
        fontWeight: FontWeight.bold,
      ),
      unselectedIconTheme: IconThemeData(color: neutralIcon),
      indicatorColor: mochaMousse.withValues(alpha: 0.12),
    ),
    iconTheme: IconThemeData(color: neutralIcon),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: GoogleFonts.poppins(color: Colors.white),
    ),
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    primaryColor: mochaMousse,
    splashColor: mochaMousse.withValues(alpha: 0.18),
    highlightColor: mochaMousse.withValues(alpha: 0.10),
    hoverColor: mochaMousse.withValues(alpha: 0.08),
    scaffoldBackgroundColor: darkBackground,
    canvasColor: darkBackground,
    cardColor: darkSurface,
    dialogTheme: DialogTheme(
      backgroundColor: darkSurface,
      titleTextStyle: GoogleFonts.poppins(
        color: mochaMousse,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      prefixIconColor: mochaMousse,
      labelStyle: GoogleFonts.poppins(color: darkOnBackground),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: mochaMousse.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: mochaMousse.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: mochaMousse, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade400, width: 2),
      ),
    ),
    // ignore: deprecated_member_use
    primarySwatch: MaterialColor(mochaMousse.value, <int, Color>{
      50: Color(0xFFF5EFE7),
      100: Color(0xFFE6DCC2),
      200: Color(0xFFD6C89C),
      300: Color(0xFFC6B576),
      400: Color(0xFFB7986B), // main
      500: Color(0xFFB7986B),
      600: Color(0xFF9C7C4B),
      700: Color(0xFF7A613A),
      800: Color(0xFF594729),
      900: Color(0xFF372C18),
    }),
    colorScheme: ColorScheme.dark(
      primary: mochaMousse,
      secondary: mochaMousse,
      surface: darkSurface,
      onSurface: darkOnBackground,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: darkSurface,
      selectedIconTheme: IconThemeData(color: mochaMousse),
      selectedLabelTextStyle: GoogleFonts.poppins(
        color: mochaMousse,
        fontWeight: FontWeight.bold,
      ),
      unselectedIconTheme: IconThemeData(color: neutralIcon),
      indicatorColor: mochaMousse.withValues(alpha: 0.18),
    ),
    iconTheme: IconThemeData(color: darkOnBackground),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.apply(
        bodyColor: darkOnBackground,
        displayColor: darkOnBackground,
      ),
    ).copyWith(titleLarge: GoogleFonts.poppins(color: darkSurface)),
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkOnBackground,
    ),
  );
}
