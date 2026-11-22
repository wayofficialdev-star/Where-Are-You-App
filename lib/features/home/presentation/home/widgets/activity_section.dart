import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// "What are you up for?" heading plus the pastel activity grid.
class ActivitySection extends StatelessWidget {
  const ActivitySection({
    required this.onActivityTap,
    required this.onSeeAll,
    this.isCompact = true,
    super.key,
  });

  final ValueChanged<String> onActivityTap;
  final VoidCallback onSeeAll;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = <_Activity>[
      _Activity(
        label: l10n.activityTeaCoffee,
        icon: Icons.emoji_food_beverage_rounded,
        background: WhereRuBrand.pastelBlue,
        foreground: WhereRuBrand.blue,
      ),
      _Activity(
        label: l10n.activityMovies,
        icon: Icons.movie_filter_rounded,
        background: WhereRuBrand.pastelPink,
        foreground: const Color(0xFFE84393),
      ),
      _Activity(
        label: l10n.activityDinner,
        icon: Icons.restaurant_rounded,
        background: WhereRuBrand.pastelPeach,
        foreground: const Color(0xFFF08A3C),
      ),
      _Activity(
        label: l10n.activityWalks,
        icon: Icons.directions_walk_rounded,
        background: WhereRuBrand.pastelMint,
        foreground: const Color(0xFF22A06B),
      ),
      _Activity(
        label: l10n.activityGamesSports,
        icon: Icons.sports_esports_rounded,
        background: WhereRuBrand.pastelPurple,
        foreground: WhereRuBrand.purple,
      ),
      _Activity(
        label: l10n.activityExploreKochi,
        icon: Icons.park_rounded,
        background: WhereRuBrand.pastelMint,
        foreground: const Color(0xFF1F9D8B),
      ),
      _Activity(
        label: l10n.activityEvents,
        icon: Icons.event_rounded,
        background: WhereRuBrand.pastelPink,
        foreground: const Color(0xFFE84393),
      ),
      _Activity(
        label: l10n.activityStudyTogether,
        icon: Icons.menu_book_rounded,
        background: WhereRuBrand.pastelBlue,
        foreground: WhereRuBrand.blue,
      ),
      _Activity(
        label: l10n.activityCafe,
        icon: Icons.local_cafe_rounded,
        background: WhereRuBrand.pastelPink,
        foreground: const Color(0xFFE84393),
      ),
      _Activity(
        label: l10n.activityMore,
        icon: Icons.more_horiz_rounded,
        background: WhereRuBrand.pastelLavender,
        foreground: WhereRuBrand.purple,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.whatAreYouUpFor,
                style: TextStyle(
                  fontSize: isCompact ? 18 : 21,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -.3,
                  color: WhereRuBrand.navy,
                ),
              ),
            ),
            _SectionAction(label: l10n.seeAll, onTap: onSeeAll),
          ],
        ),
        SizedBox(height: isCompact ? 12 : 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: isCompact ? 8 : 10,
            crossAxisSpacing: isCompact ? 8 : 10,
            childAspectRatio: isCompact ? .85 : 1.12,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return _ActivityTile(
              activity: item,
              isCompact: isCompact,
              onTap: () => onActivityTap(item.label),
            );
          },
        ),
      ],
    );
  }
}

class _Activity {
  const _Activity({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.isCompact,
    required this.onTap,
  });

  final _Activity activity;
  final bool isCompact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(isCompact ? 14 : 16);

    return Semantics(
      button: true,
      label: activity.label,
      child: Material(
        color: activity.background,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.all(isCompact ? 3 : 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  activity.icon,
                  size: isCompact ? 20 : 30,
                  color: activity.foreground,
                ),
                SizedBox(height: isCompact ? 3 : 6),
                Flexible(
                  child: Text(
                    activity.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isCompact ? 9.5 : 12,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: WhereRuBrand.navy,
                    ),
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

class _SectionAction extends StatelessWidget {
  const _SectionAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: WhereRuBrand.purple,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: WhereRuBrand.purple,
            ),
          ],
        ),
      ),
    );
  }
}
