import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Navigation shell for the Where RU destinations.
///
/// Phones get the floating pill bar from the reference, wide layouts get a
/// rail. Both drive the same GoRouter locations so deep links and back
/// navigation stay consistent.
class AppShell extends StatelessWidget {
  const AppShell({required this.location, required this.child, super.key});

  final String location;
  final Widget child;

  /// Home, Matches, Chat and Profile, in bar order.
  static const List<String> paths = [
    AppRouter.homePath,
    AppRouter.findSomeonePath,
    AppRouter.chatPath,
    AppRouter.profilePath,
  ];

  // TODO(where-ru): replace with the real unread counter from the chat
  // repository once the backend exposes it.
  static const int unreadChats = 2;

  int get _selectedIndex {
    // Nested destinations (for example the matchmaking steps under
    // /find-someone) keep their parent tab selected.
    var match = -1;
    for (var i = 0; i < paths.length; i++) {
      final isMatch =
          location == paths[i] || location.startsWith('${paths[i]}/');
      if (isMatch && (match == -1 || paths[i].length > paths[match].length)) {
        match = i;
      }
    }
    return match == -1 ? 0 : match;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    context.go(paths[index]);
  }

  List<_Destination> _destinations(BuildContext context) {
    return [
      _Destination(
        label: context.l10n.home,
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
      ),
      _Destination(
        label: context.l10n.matches,
        icon: Icons.groups_outlined,
        selectedIcon: Icons.groups_rounded,
      ),
      _Destination(
        label: context.l10n.chat,
        icon: Icons.chat_bubble_outline_rounded,
        selectedIcon: Icons.chat_bubble_rounded,
        badgeCount: unreadChats,
      ),
      _Destination(
        label: context.l10n.profile,
        icon: Icons.person_outline_rounded,
        selectedIcon: Icons.person_rounded,
      ),
    ];
  }

  Widget _withBadge(IconData icon, Color color, int? badgeCount) {
    final iconWidget = Icon(icon, size: 23, color: color);
    if (badgeCount == null || badgeCount <= 0) return iconWidget;

    return Badge.count(
      count: badgeCount,
      backgroundColor: WhereRuBrand.danger,
      textColor: AppColors.white,
      smallSize: 15,
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _destinations(context);
    final selectedIndex = _selectedIndex;

    if (ResponsiveWidget.isLargeScreen(context)) {
      return Scaffold(
        backgroundColor: WhereRuBrand.background,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              backgroundColor: AppColors.white,
              indicatorColor: WhereRuBrand.pastelPurple,
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: const IconThemeData(
                color: WhereRuBrand.purple,
              ),
              selectedLabelTextStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: WhereRuBrand.purple,
              ),
              unselectedLabelTextStyle: const TextStyle(
                fontSize: 12,
                color: WhereRuBrand.hint,
              ),
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: WhereRuLogo(width: 46),
              ),
              destinations: [
                for (final destination in destinations)
                  NavigationRailDestination(
                    icon: _withBadge(
                      destination.icon,
                      WhereRuBrand.hint,
                      destination.badgeCount,
                    ),
                    selectedIcon: _withBadge(
                      destination.selectedIcon,
                      WhereRuBrand.purple,
                      destination.badgeCount,
                    ),
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

    final radius = BorderRadius.circular(24);

    return Scaffold(
      backgroundColor: WhereRuBrand.background,
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: radius,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 28,
                  color: WhereRuBrand.navy.withValues(alpha: .1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: radius,
              child: Row(
                children: [
                  for (var i = 0; i < destinations.length; i++) ...[
                    if (i > 0)
                      Container(
                        width: 1,
                        height: 46,
                        color: WhereRuBrand.hairline,
                      ),
                    Expanded(
                      child: _NavItem(
                        destination: destinations[i],
                        isSelected: i == selectedIndex,
                        onTap: () => _onDestinationSelected(context, i),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.badgeCount,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final int? badgeCount;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final _Destination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? WhereRuBrand.purple : WhereRuBrand.hint;
    final badgeCount = destination.badgeCount ?? 0;

    return Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      isSelected ? destination.selectedIcon : destination.icon,
                      size: 23,
                      color: color,
                    ),
                    if (badgeCount > 0)
                      Positioned(
                        right: -12,
                        top: -6,
                        child: _Badge(count: badgeCount),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 20,
                height: 3,
                decoration: BoxDecoration(
                  color: isSelected ? WhereRuBrand.purple : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
      decoration: BoxDecoration(
        color: WhereRuBrand.danger,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.white, width: 1.5),
      ),
      child: Center(
        child: Text(
          '$count',
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            height: 1,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
