import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/about_page.dart';
import 'ui/pages/projects_page.dart';
import 'ui/pages/experience_page.dart';
import 'ui/pages/contact_page.dart';
import 'ui/pages/education_page.dart';
import 'ui/pages/certificates_page.dart';
import 'ui/pages/migration_page.dart';
import 'utils/web_env.dart' if (dart.library.io) 'utils/empty_env.dart';
// import 'data/supabase/migrate_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:
        kIsWeb
            ? getEnv('SUPABASE_URL')
            : const String.fromEnvironment('SUPABASE_URL'),
    anonKey:
        kIsWeb
            ? getEnv('SUPABASE_ANON_KEY')
            : const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  // Uncomment the following line to migrate data (run only once)
  // await DataMigration().migrateAllData();

  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const PortfolioApp()));
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

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
            '/education': (context) => const EducationPage(),
            '/certificates': (context) => const CertificatesPage(),
            '/migration': (context) => const MigrationPage(),
          },
        );
      },
    );
  }
}
