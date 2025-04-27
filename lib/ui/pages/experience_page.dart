import 'package:flutter/material.dart';
import '../../data/data_sources/experience_data.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ResponsiveLayout(
        desktop: _buildTimeline(context, width: 700),
        tablet: _buildTimeline(context, width: 500),
        mobile: _buildTimeline(context, width: double.infinity),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, {required double width}) {
    return Center(
      child: SizedBox(
        width: width,
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: experiences.length,
          separatorBuilder: (context, i) => const SizedBox(height: 24),
          itemBuilder: (context, i) {
            final exp = experiences[i];
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
                              Icons.work,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              exp.role,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          exp.company,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exp.duration,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        ...exp.achievements.map(
                          (a) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontSize: 16)),
                              Expanded(
                                child: Text(
                                  a,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
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
