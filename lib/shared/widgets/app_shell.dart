import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Navigation shell for the Where RU destinations.
///
/// Phones get a bottom navigation bar, wide layouts get a rail. Both drive the
/// same GoRouter locations so deep links and back navigation stay consistent.
class AppShell extends StatelessWidget {
  const AppShell({required this.location, required this.child, super.key});

  final String location;
  final Widget child;

  static const List<String> paths = [
    AppRouter.homePath,
    AppRouter.findSomeonePath,
    AppRouter.meetingsPath,
    AppRouter.profilePath,
  ];

  int get _selectedIndex {
    final index = paths.indexOf(location);
    return index == -1 ? 0 : index;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    context.go(paths[index]);
  }

  List<NavigationDestination> _destinations(BuildContext context) {
    final labels = [
      context.l10n.home,
      context.l10n.findSomeoneTitle,
      context.l10n.meetings,
      context.l10n.profile,
    ];
    const icons = [
      (Icons.home_outlined, Icons.home_rounded),
      (Icons.person_search_outlined, Icons.person_search_rounded),
      (Icons.handshake_outlined, Icons.handshake_rounded),
      (Icons.person_outline_rounded, Icons.person_rounded),
    ];

    return [
      for (var i = 0; i < labels.length; i++)
        NavigationDestination(
          icon: Icon(icons[i].$1),
          selectedIcon: Icon(icons[i].$2, color: WhereRuBrand.purple),
          label: labels[i],
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return Scaffold(
        backgroundColor: WhereRuBrand.background,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              backgroundColor: AppColors.white,
              indicatorColor: WhereRuBrand.pastelPurple,
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: WhereRuBrand.gradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.explore_rounded,
                    color: AppColors.white,
                  ),
                ),
              ),
              destinations: [
                for (final destination in _destinations(context))
                  NavigationRailDestination(
                    icon: destination.icon,
                    selectedIcon: destination.selectedIcon,
                    label: Text(destination.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: WhereRuBrand.background,
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
        backgroundColor: AppColors.white,
        indicatorColor: WhereRuBrand.pastelPurple,
        destinations: _destinations(context),
      ),
    );
  }
}
