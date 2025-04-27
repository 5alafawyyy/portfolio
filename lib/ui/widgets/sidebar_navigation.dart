import 'package:flutter/material.dart';

class SidebarNavigation extends StatelessWidget {
  final String selectedRoute;
  final void Function(String route) onNavigate;
  const SidebarNavigation({
    Key? key,
    required this.selectedRoute,
    required this.onNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _SidebarItem('Home', '/', Icons.home),
      _SidebarItem('About Me', '/about', Icons.person),
      _SidebarItem('Projects', '/projects', Icons.apps),
      _SidebarItem('Experience', '/experience', Icons.timeline),
    ];
    return Container(
      width: 220,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ...navItems.map(
            (item) => _SidebarNavTile(
              label: item.label,
              icon: item.icon,
              selected: selectedRoute == item.route,
              onTap: () => onNavigate(item.route),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem {
  final String label;
  final String route;
  final IconData icon;
  _SidebarItem(this.label, this.route, this.icon);
}

class _SidebarNavTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _SidebarNavTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
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
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? Theme.of(context).colorScheme.primary : null,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color:
                      selected ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
