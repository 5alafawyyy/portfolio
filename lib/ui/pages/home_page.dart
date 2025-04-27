import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'about_page.dart';
import 'projects_page.dart';
import 'experience_page.dart';
import 'contact_page.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  static const List<String> _routes = [
    '/',
    '/about',
    '/projects',
    '/experience',
    '/contact',
  ];

  void _onSidebarNavigate(String route) {
    final idx = _routes.indexOf(route);
    if (idx != -1) setState(() => selectedIndex = idx);
  }

  Widget _mainContent(
    BuildContext context, {
    double width = 400,
    double avatarSize = 180,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add Rive animation at the top of the intro
              SizedBox(
                width: avatarSize,
                height: avatarSize,
                child: RiveAnimation.asset('assets/animations/intro.riv'),
              ),
              const SizedBox(height: 32),
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 2),
                child: Column(
                  children: [
                    Text(
                      AppConstants.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 700.ms, delay: 200.ms),
                    const SizedBox(height: 12),
                    Text(
                      AppConstants.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 700.ms, delay: 300.ms),
                    const SizedBox(height: 12),
                    Text(
                      AppConstants.location,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 700.ms, delay: 400.ms),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Contact & Social',
                style: Theme.of(context).textTheme.titleMedium,
              ).animate().fadeIn(duration: 700.ms, delay: 500.ms),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton(
                        context,
                        icon: Icons.email,
                        tooltip: 'Email',
                        url: 'mailto:${AppConstants.email}',
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .scale(delay: 600.ms),
                  _socialButton(
                        context,
                        icon: Icons.code,
                        tooltip: 'GitHub',
                        url: AppConstants.github,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 700.ms)
                      .scale(delay: 700.ms),
                  _socialButton(
                        context,
                        icon: Icons.business,
                        tooltip: 'LinkedIn',
                        url: AppConstants.linkedin,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 800.ms)
                      .scale(delay: 800.ms),
                  _socialButton(
                        context,
                        icon: Icons.chat,
                        tooltip: 'WhatsApp',
                        url: AppConstants.whatsapp,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 900.ms)
                      .scale(delay: 900.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(
    BuildContext context, {
    required IconData icon,
    required String tooltip,
    required String url,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        size: 28,
        color: Theme.of(context).colorScheme.secondary,
      ),
      tooltip: tooltip,
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      splashRadius: 24,
    );
  }

  Widget _getPage(
    int index,
    BuildContext context,
    double width,
    double avatarSize,
  ) {
    switch (index) {
      case 1:
        return const AboutPage();
      case 2:
        return const ProjectsPage();
      case 3:
        return const ExperiencePage();
      case 4:
        return const ContactPage();
      default:
        return _mainContent(context, width: width, avatarSize: avatarSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktop: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (idx) => setState(() => selectedIndex = idx),
            labelType: NavigationRailLabelType.none,
            backgroundColor:
                Theme.of(context).navigationRailTheme.backgroundColor,
            destinations: const [
              NavigationRailDestination(
                icon: Tooltip(message: 'Home', child: Icon(Icons.home)),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Tooltip(message: 'About Me', child: Icon(Icons.person)),
                label: Text('About Me'),
              ),
              NavigationRailDestination(
                icon: Tooltip(message: 'Projects', child: Icon(Icons.apps)),
                label: Text('Projects'),
              ),
              NavigationRailDestination(
                icon: Tooltip(
                  message: 'Experience',
                  child: Icon(Icons.timeline),
                ),
                label: Text('Experience'),
              ),
              NavigationRailDestination(
                icon: Tooltip(message: 'Contact', child: Icon(Icons.mail)),
                label: Text('Contact'),
              ),
            ],
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: const SizedBox.shrink(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.brightness_6),
                    onPressed: widget.onToggleTheme,
                  ),
                ],
                automaticallyImplyLeading: false,
              ),
              body: _getPage(selectedIndex, context, 600, 220),
            ),
          ),
        ],
      ),
      tablet: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (idx) => setState(() => selectedIndex = idx),
            labelType: NavigationRailLabelType.none,
            backgroundColor:
                Theme.of(context).navigationRailTheme.backgroundColor,
            destinations: const [
              NavigationRailDestination(
                icon: Tooltip(message: 'Home', child: Icon(Icons.home)),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Tooltip(message: 'About Me', child: Icon(Icons.person)),
                label: Text('About Me'),
              ),
              NavigationRailDestination(
                icon: Tooltip(message: 'Projects', child: Icon(Icons.apps)),
                label: Text('Projects'),
              ),
              NavigationRailDestination(
                icon: Tooltip(
                  message: 'Experience',
                  child: Icon(Icons.timeline),
                ),
                label: Text('Experience'),
              ),
              NavigationRailDestination(
                icon: Tooltip(message: 'Contact', child: Icon(Icons.mail)),
                label: Text('Contact'),
              ),
            ],
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: const SizedBox.shrink(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.brightness_6),
                    onPressed: widget.onToggleTheme,
                  ),
                ],
                automaticallyImplyLeading: false,
              ),
              body: _getPage(selectedIndex, context, 500, 180),
            ),
          ),
        ],
      ),
      mobile: Scaffold(
        appBar: AppBar(
          title: const SizedBox.shrink(),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: widget.onToggleTheme,
            ),
          ],
        ),
        body: _getPage(selectedIndex, context, double.infinity, 120),
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(height: 32),
              _DrawerIconButton(
                icon: Icons.home,
                tooltip: 'Home',
                selected: selectedIndex == 0,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              _DrawerIconButton(
                icon: Icons.person,
                tooltip: 'About Me',
                selected: selectedIndex == 1,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              _DrawerIconButton(
                icon: Icons.apps,
                tooltip: 'Projects',
                selected: selectedIndex == 2,
                onTap: () => setState(() => selectedIndex = 2),
              ),
              _DrawerIconButton(
                icon: Icons.timeline,
                tooltip: 'Experience',
                selected: selectedIndex == 3,
                onTap: () => setState(() => selectedIndex = 3),
              ),
              _DrawerIconButton(
                icon: Icons.mail,
                tooltip: 'Contact',
                selected: selectedIndex == 4,
                onTap: () => setState(() => selectedIndex = 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool selected;
  final VoidCallback onTap;
  const _DrawerIconButton({
    required this.icon,
    required this.tooltip,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color:
            selected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Icon(
              icon,
              color: selected ? Theme.of(context).colorScheme.primary : null,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
