import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../data/data_sources/projects_data.dart';
import '../widgets/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktop: _buildGrid(context, crossAxisCount: 3),
        tablet: _buildGrid(context, crossAxisCount: 2),
        mobile: _buildGrid(context, crossAxisCount: 1),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, {required int crossAxisCount}) {
    double aspectRatio = 0.7;
    if (crossAxisCount == 3) aspectRatio = 1.05; // desktop (less tall)
    if (crossAxisCount == 2) aspectRatio = 0.75; // tablet
    if (crossAxisCount == 1) aspectRatio = 0.95; // mobile
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        itemCount: projects.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (context, index) {
          final project = projects[index];
          return _ProjectCard(project: project)
              .animate()
              .fadeIn(duration: 600.ms, delay: (index * 120).ms)
              .slideY(
                begin: 0.1,
                end: 0,
                duration: 600.ms,
                delay: (index * 120).ms,
              );
        },
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 380),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                    ),
                    items:
                        project.screenshots
                            .map<Widget>(
                              (img) => ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: img,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 180,
                                  placeholder:
                                      (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          Icon(Icons.error),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              project.tech
                                  .map<Widget>((t) => Chip(label: Text(t)))
                                  .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 8.0,
                  ),
                  child: Wrap(
                    spacing: 8,
                    children:
                        project.links.entries
                            .map<Widget>(
                              (entry) => IconButton(
                                icon: _getLinkIcon(entry.key),
                                tooltip: entry.key,
                                onPressed: () async {
                                  final uri = Uri.parse(entry.value);
                                  if (uri.toString().isNotEmpty &&
                                      await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Icon _getLinkIcon(String key) {
    switch (key) {
      case 'Google Play':
        return const Icon(Icons.android);
      case 'App Store':
        return const Icon(Icons.apple);
      case 'GitHub':
        return const Icon(Icons.code);
      case 'Huawei App Gallery':
        return const Icon(Icons.apps);
      default:
        return const Icon(Icons.link);
    }
  }
}
