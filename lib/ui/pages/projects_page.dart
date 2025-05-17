import 'package:flutter/material.dart';
import '../../data/data_sources/projects_data.dart';
import '../../data/models/project_model.dart';
import '../widgets/project_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/shimmer_loading.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ProjectsDataSource _dataSource = ProjectsDataSource();
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _dataSource.getProjects();
  }

  Widget _buildShimmerGrid(int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: 6, // Show 6 shimmer cards
      itemBuilder: (context, index) {
        return const ShimmerProjectCard()
            .animate()
            .fadeIn(duration: 600.ms, delay: (100 * index).ms)
            .slideY(
              begin: 0.2,
              end: 0,
              duration: 600.ms,
              delay: (100 * index).ms,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ResponsiveLayout(
            desktop: _buildShimmerGrid(3),
            tablet: _buildShimmerGrid(2),
            mobile: _buildShimmerGrid(1),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading projects: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final projects = snapshot.data ?? [];
        if (projects.isEmpty) {
          return const Center(child: Text('No projects found'));
        }

        return ResponsiveLayout(
          desktop: _buildProjectsGrid(projects, 3),
          tablet: _buildProjectsGrid(projects, 2),
          mobile: _buildProjectsGrid(projects, 1),
        );
      },
    );
  }

  Widget _buildProjectsGrid(List<Project> projects, int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return ProjectCard(project: project)
            .animate()
            .fadeIn(duration: 600.ms, delay: (100 * index).ms)
            .slideY(
              begin: 0.2,
              end: 0,
              duration: 600.ms,
              delay: (100 * index).ms,
            );
      },
    );
  }
}
