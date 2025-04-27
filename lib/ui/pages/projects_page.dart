import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:portfolio/data/models/project_model.dart';
import '../../data/data_sources/projects_data.dart';
import '../widgets/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

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
    if (crossAxisCount == 3) aspectRatio = 1.25; // desktop (less tall)
    if (crossAxisCount == 2) aspectRatio = 0.75; // tablet
    if (crossAxisCount == 1) aspectRatio = 0.72; // mobile
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

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    // Responsive height for expanded card
    final double expandedHeight =
        MediaQuery.of(context).size.width < 600 ? 320 : 420;
    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: AnimatedCrossFade(
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 350),
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(project.icon),
                    radius: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        project.tech
                            .map<Widget>((t) => Chip(label: Text(t)))
                            .toList(),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
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
                  const SizedBox(height: 8),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            secondChild: SizedBox(
              height: expandedHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage(project.icon),
                          radius: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          project.name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      if (project.screenshots.isNotEmpty)
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
                                project.screenshots.map<Widget>((img) {
                                  if (img.startsWith('http')) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        img,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 180,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                      ),
                                    );
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        img,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 180,
                                      ),
                                    );
                                  }
                                }).toList(),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children:
                            project.tech
                                .map<Widget>((t) => Chip(label: Text(t)))
                                .toList(),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
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
                      const SizedBox(height: 8),
                      Center(
                        child: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
