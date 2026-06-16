import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/design_tokens.dart';
import '../../features/favorites/application/favorites_controller.dart';

class _Destination {
  const _Destination(this.label, this.icon, this.selectedIcon);
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const _destinations = <_Destination>[
  _Destination('Home', Icons.home_outlined, Icons.home),
  _Destination('Search', Icons.search_outlined, Icons.search),
  _Destination('Saved', Icons.favorite_outline, Icons.favorite),
  _Destination('Inquiries', Icons.forum_outlined, Icons.forum),
  _Destination('Account', Icons.person_outline, Icons.person),
];

/// Adaptive app shell: a bottom [NavigationBar] on compact screens, a
/// [NavigationRail] on medium, and an extended rail on expanded/desktop.
class AppScaffold extends ConsumerWidget {
  const AppScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favCount = ref.watch(favoritesControllerProvider).value?.length ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final selected = navigationShell.currentIndex;

        if (Breakpoints.isCompact(width)) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: selected,
              onDestinationSelected: _goBranch,
              destinations: [
                for (var i = 0; i < _destinations.length; i++)
                  NavigationDestination(
                    icon: _badge(i, favCount, _destinations[i].icon),
                    selectedIcon:
                        _badge(i, favCount, _destinations[i].selectedIcon),
                    label: _destinations[i].label,
                  ),
              ],
            ),
          );
        }

        final extended = Breakpoints.isExpanded(width);
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                extended: extended,
                minExtendedWidth: 200,
                selectedIndex: selected,
                onDestinationSelected: _goBranch,
                groupAlignment: -0.85,
                leading: _RailHeader(extended: extended),
                destinations: [
                  for (var i = 0; i < _destinations.length; i++)
                    NavigationRailDestination(
                      icon: _badge(i, favCount, _destinations[i].icon),
                      selectedIcon:
                          _badge(i, favCount, _destinations[i].selectedIcon),
                      label: Text(_destinations[i].label),
                    ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: navigationShell),
            ],
          ),
        );
      },
    );
  }

  // The "Saved" tab (index 2) shows a Badge with the favorites count.
  Widget _badge(int index, int count, IconData icon) {
    if (index == 2 && count > 0) {
      return Badge(label: Text('$count'), child: Icon(icon));
    }
    return Icon(icon);
  }
}

class _RailHeader extends StatelessWidget {
  const _RailHeader({required this.extended});
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cottage_rounded, color: scheme.primary, size: 28),
          if (extended) ...[
            const SizedBox(width: AppSpacing.sm),
            Text('Dwellio',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ],
      ),
    );
  }
}
