import 'package:flutter/material.dart';
import '../../data/data_sources/education_data.dart';
import '../../data/models/education_model.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final EducationDataSource _dataSource = EducationDataSource();
  late Future<List<Education>> _educationFuture;

  @override
  void initState() {
    super.initState();
    _educationFuture = _dataSource.getEducation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Education>>(
      future: _educationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading education: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final educations = snapshot.data ?? [];
        if (educations.isEmpty) {
          return const Center(child: Text('No education found'));
        }

        return Scaffold(
          body: ResponsiveLayout(
            desktop: _buildList(context, width: 700, educations: educations),
            tablet: _buildList(context, width: 500, educations: educations),
            mobile: _buildList(
              context,
              width: double.infinity,
              educations: educations,
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context, {
    required double width,
    required List<Education> educations,
  }) {
    return Center(
      child: SizedBox(
        width: width,
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: educations.length,
          separatorBuilder: (context, i) => const SizedBox(height: 24),
          itemBuilder: (context, i) {
            final edu = educations[i];
            return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.school,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                edu.degree,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          edu.institution,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          edu.duration,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: (i * 120).ms)
                .slideY(
                  begin: 0.1,
                  end: 0,
                  duration: 600.ms,
                  delay: (i * 120).ms,
                );
          },
        ),
      ),
    );
  }
}
