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
    textTheme: GoogleFonts.poppinsTextTheme(),
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
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkOnBackground,
    ),
  );
}
