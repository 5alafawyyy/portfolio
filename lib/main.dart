import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/about_page.dart';
import 'ui/pages/projects_page.dart';
import 'ui/pages/experience_page.dart';
import 'ui/pages/contact_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahmed Khallaf Portfolio',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(onToggleTheme: _toggleTheme),
        '/about': (context) => const AboutPage(),
        '/projects': (context) => const ProjectsPage(),
        '/experience': (context) => const ExperiencePage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
