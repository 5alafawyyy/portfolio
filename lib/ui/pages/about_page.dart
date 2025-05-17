import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/supabase/supabase_service.dart';
import '../../data/models/about_model.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Widget _buildSkillsList(List<String> skills, {required IconData icon}) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          skills
              .map((skill) => Chip(label: Text(skill), avatar: Icon(icon)))
              .toList(),
    );
  }

  Widget _mainContent(BuildContext context, {double width = 500}) {
    final supabaseService = SupabaseService();

    return Center(
      child: SizedBox(
        width: width,
        child: FutureBuilder<Map<String, About>>(
          future: supabaseService.getAllAboutSections(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final sections = snapshot.data!;
            final summary = sections['professional_summary']!;
            final skills = sections['skills']!;
            final techStack = sections['tech_stack']!;

            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Professional Summary',
                  style: Theme.of(context).textTheme.titleLarge,
                ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
                const SizedBox(height: 8),
                Text(
                  summary.content,
                  style: const TextStyle(fontSize: 16),
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                const SizedBox(height: 24),
                Text(
                  'Skills',
                  style: Theme.of(context).textTheme.titleLarge,
                ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                const SizedBox(height: 8),
                _buildSkillsList(
                  skills.skills ?? [],
                  icon: Icons.star,
                ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                const SizedBox(height: 24),
                Text(
                  'Tech Stack',
                  style: Theme.of(context).textTheme.titleLarge,
                ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                const SizedBox(height: 8),
                _buildSkillsList(
                  techStack.skills ?? [],
                  icon: Icons.code,
                ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktop: _mainContent(context, width: 700),
        tablet: _mainContent(context, width: 500),
        mobile: _mainContent(context, width: double.infinity),
      ),
    );
  }
}
