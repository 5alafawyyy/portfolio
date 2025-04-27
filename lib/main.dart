import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/about_page.dart';
import 'ui/pages/projects_page.dart';
import 'ui/pages/experience_page.dart';
import 'ui/pages/contact_page.dart';

void main() {
  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const PortfolioApp()));
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Ahmed Khallaf Portfolio',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          initialRoute: '/',
          routes: {
            '/':
                (context) => HomePage(
                  onToggleTheme:
                      () => context.read<ThemeBloc>().add(ThemeEvent.toggle),
                ),
            '/about': (context) => const AboutPage(),
            '/projects': (context) => const ProjectsPage(),
            '/experience': (context) => const ExperiencePage(),
            '/contact': (context) => const ContactPage(),
          },
        );
      },
    );
  }
}
