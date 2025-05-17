import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final double expandedHeight =
        MediaQuery.of(context).size.width < 600 ? 380 : 560;

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
            firstChild: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(project.iconUrl),
                      radius: 32,
                      onBackgroundImageError: (_, __) {},
                    ),
                    const SizedBox(height: 12),
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
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
                              .map<Widget>(
                                (t) => Container(
                                  margin: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: Chip(
                                    label: Text(
                                      t,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              )
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
                          backgroundImage: NetworkImage(project.iconUrl),
                          radius: 32,
                          onBackgroundImageError: (_, __) {},
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
                          height: 400,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 400,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              viewportFraction: 1.0,
                            ),
                            items:
                                project.screenshots.map<Widget>((img) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      img,
                                      fit: BoxFit.fitHeight,
                                      width: double.infinity,
                                      height: 300,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children:
                            project.tech
                                .map<Widget>(
                                  (t) => Container(
                                    margin: const EdgeInsets.only(
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    child: Chip(
                                      label: Text(
                                        t,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                )
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
