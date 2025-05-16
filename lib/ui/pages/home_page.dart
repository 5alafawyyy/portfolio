import 'package:flutter/material.dart';
import '../../data/data_sources/profile_data.dart';
import '../../data/models/profile_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'about_page.dart';
import 'projects_page.dart';
import 'experience_page.dart';
import 'contact_page.dart';
import 'education_page.dart';
import 'certificates_page.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/material.dart' as material;
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final ProfileDataSource _profileDataSource = ProfileDataSource();
  late Future<Profile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileDataSource.getProfile();
  }

  static const List<String> _titles = [
    '',
    'About Me',
    'Projects',
    'Experience',
    'Education',
    'Certificates',
    'Contact',
  ];

  String get _currentTitle => _titles[selectedIndex];

  void _onMobileNavTap(int idx) {
    setState(() => selectedIndex = idx);
    Navigator.of(context).maybePop();
  }

  Widget _mainContent(
    BuildContext context, {
    double width = 400,
    double avatarSize = 180,
  }) {
    return FutureBuilder<Profile>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading profile: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final profile = snapshot.data!;
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
                  SizedBox(
                    width: avatarSize,
                    height: avatarSize,
                    child: rive.RiveAnimation.asset(
                      'assets/animations/intro.riv',
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: Column(
                      children: [
                        Text(
                          profile.name,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 700.ms, delay: 200.ms),
                        const SizedBox(height: 12),
                        Text(
                          profile.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 700.ms, delay: 300.ms),
                        const SizedBox(height: 12),
                        Text(
                          profile.location,
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
                      _socialAssetButton(
                            context,
                            asset: 'assets/icons/gmail.png',
                            tooltip: 'Email',
                            url: 'mailto:${profile.email}',
                          )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 600.ms)
                          .scale(delay: 600.ms),
                      _socialAssetButton(
                            context,
                            asset: 'assets/icons/github.png',
                            tooltip: 'GitHub',
                            url: profile.github,
                          )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 700.ms)
                          .scale(delay: 700.ms),
                      _socialAssetButton(
                            context,
                            asset: 'assets/icons/linkedin.png',
                            tooltip: 'LinkedIn',
                            url: profile.linkedin,
                          )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 800.ms)
                          .scale(delay: 800.ms),
                      _socialAssetButton(
                            context,
                            asset: 'assets/icons/whatsapp.png',
                            tooltip: 'WhatsApp',
                            url: profile.whatsapp,
                          )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 900.ms)
                          .scale(delay: 900.ms),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _AnimatedShimmerButton(
                    icon: Icons.download,
                    label: 'Download CV',
                    onPressed: () async {
                      final uri = Uri.parse(profile.cvUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _socialAssetButton(
    BuildContext context, {
    required String asset,
    required String tooltip,
    required String url,
  }) {
    return IconButton(
      icon: ImageIcon(
        AssetImage(asset),
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
        return const EducationPage();
      case 5:
        return const CertificatesPage();
      case 6:
        return const ContactPage();
      default:
        return _mainContent(context, width: width, avatarSize: avatarSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(_currentTitle),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: widget.onToggleTheme,
        ),
      ],
    );

    return FutureBuilder<Profile>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading profile: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final profile = snapshot.data!;
        return ResponsiveLayout(
          desktop: Row(
            children: [
              Container(
                width: 80,
                color: Theme.of(context).navigationRailTheme.backgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Material(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(profile.avatarUrl),
                            onBackgroundImageError: (_, __) {},
                          ),
                          const SizedBox(height: 10),
                          Text(
                            profile.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: NavigationRail(
                        selectedIndex: selectedIndex,
                        onDestinationSelected:
                            (idx) => setState(() => selectedIndex = idx),
                        labelType: NavigationRailLabelType.none,
                        backgroundColor:
                            Theme.of(
                              context,
                            ).navigationRailTheme.backgroundColor,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Home',
                              child: Icon(Icons.home),
                            ),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'About Me',
                              child: Icon(Icons.person),
                            ),
                            label: Text('About Me'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Projects',
                              child: Icon(Icons.apps),
                            ),
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
                            icon: Tooltip(
                              message: 'Education',
                              child: Icon(Icons.school),
                            ),
                            label: Text('Education'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Certificates',
                              child: Icon(Icons.workspace_premium),
                            ),
                            label: Text('Certificates'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Contact',
                              child: Icon(Icons.mail),
                            ),
                            label: Text('Contact'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  appBar: appBar,
                  body: _getPage(selectedIndex, context, 600, 220),
                ),
              ),
            ],
          ),
          tablet: Row(
            children: [
              Container(
                width: 80,
                color: Theme.of(context).navigationRailTheme.backgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Material(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(profile.avatarUrl),
                            onBackgroundImageError: (_, __) {},
                          ),
                          const SizedBox(height: 10),
                          Text(
                            profile.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: NavigationRail(
                        selectedIndex: selectedIndex,
                        onDestinationSelected:
                            (idx) => setState(() => selectedIndex = idx),
                        labelType: NavigationRailLabelType.none,
                        backgroundColor:
                            Theme.of(
                              context,
                            ).navigationRailTheme.backgroundColor,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Home',
                              child: Icon(Icons.home),
                            ),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'About Me',
                              child: Icon(Icons.person),
                            ),
                            label: Text('About Me'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Projects',
                              child: Icon(Icons.apps),
                            ),
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
                            icon: Tooltip(
                              message: 'Education',
                              child: Icon(Icons.school),
                            ),
                            label: Text('Education'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Certificates',
                              child: Icon(Icons.workspace_premium),
                            ),
                            label: Text('Certificates'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Contact',
                              child: Icon(Icons.mail),
                            ),
                            label: Text('Contact'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  appBar: appBar,
                  body: _getPage(selectedIndex, context, 500, 180),
                ),
              ),
            ],
          ),
          mobile: Scaffold(
            appBar: AppBar(
              title: Text(_currentTitle),
              centerTitle: true,
              automaticallyImplyLeading: true,
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
                  Material(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundImage: NetworkImage(profile.avatarUrl),
                          onBackgroundImageError: (_, __) {},
                        ),
                        const SizedBox(height: 12),
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _DrawerIconButton(
                    icon: Icons.home,
                    tooltip: 'Home',
                    selected: selectedIndex == 0,
                    onTap: () => _onMobileNavTap(0),
                  ),
                  _DrawerIconButton(
                    icon: Icons.person,
                    tooltip: 'About Me',
                    selected: selectedIndex == 1,
                    onTap: () => _onMobileNavTap(1),
                  ),
                  _DrawerIconButton(
                    icon: Icons.apps,
                    tooltip: 'Projects',
                    selected: selectedIndex == 2,
                    onTap: () => _onMobileNavTap(2),
                  ),
                  _DrawerIconButton(
                    icon: Icons.timeline,
                    tooltip: 'Experience',
                    selected: selectedIndex == 3,
                    onTap: () => _onMobileNavTap(3),
                  ),
                  _DrawerIconButton(
                    icon: Icons.school,
                    tooltip: 'Education',
                    selected: selectedIndex == 4,
                    onTap: () => _onMobileNavTap(4),
                  ),
                  _DrawerIconButton(
                    icon: Icons.workspace_premium,
                    tooltip: 'Certificates',
                    selected: selectedIndex == 5,
                    onTap: () => _onMobileNavTap(5),
                  ),
                  _DrawerIconButton(
                    icon: Icons.mail,
                    tooltip: 'Contact',
                    selected: selectedIndex == 6,
                    onTap: () => _onMobileNavTap(6),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color:
                      selected ? Theme.of(context).colorScheme.primary : null,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  tooltip,
                  style: TextStyle(
                    color:
                        selected ? Theme.of(context).colorScheme.primary : null,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedShimmerButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const _AnimatedShimmerButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_AnimatedShimmerButton> createState() => _AnimatedShimmerButtonState();
}

class _AnimatedShimmerButtonState extends State<_AnimatedShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shadowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _shadowAnim = Tween<double>(
      begin: 0,
      end: 16,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                blurRadius: _shadowAnim.value,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.7),
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  Colors.white.withOpacity(0.7),
                ],
                stops: const [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.mirror,
                transform: GradientRotation(_controller.value * 2 * 3.1416),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: ElevatedButton.icon(
              icon: Icon(widget.icon),
              label: Text(widget.label),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: widget.onPressed,
            ),
          ),
        );
      },
    );
  }
}
