import 'package:flutter/material.dart';
import '../../data/data_sources/education_data.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ResponsiveLayout(
        desktop: _buildList(context, width: 700),
        tablet: _buildList(context, width: 500),
        mobile: _buildList(context, width: double.infinity),
      ),
    );
  }

  Widget _buildList(BuildContext context, {required double width}) {
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
