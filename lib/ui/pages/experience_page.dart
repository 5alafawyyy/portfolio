import 'package:flutter/material.dart';
import '../../data/data_sources/experience_data.dart';
import '../../data/models/experience_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final ExperienceDataSource _dataSource = ExperienceDataSource();
  late Future<List<Experience>> _experienceFuture;

  @override
  void initState() {
    super.initState();
    _experienceFuture = _dataSource.getExperience();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Experience>>(
      future: _experienceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading experience: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final experiences = snapshot.data ?? [];
        if (experiences.isEmpty) {
          return const Center(child: Text('No experience found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final experience = experiences[index];
            return Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.role,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          experience.company,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          experience.duration,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...experience.achievements.map(
                          (achievement) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.arrow_right, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    achievement,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                .slideX(
                  begin: 0.2,
                  end: 0,
                  duration: 600.ms,
                  delay: (100 * index).ms,
                );
          },
        );
      },
    );
  }
}
