import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:app/features/find_someone/presentation/find_someone/widgets/labels.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// 3 x 2 grid of pastel activity cards.
class ActivityPicker extends StatelessWidget {
  const ActivityPicker({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final MatchActivity? selected;
  final ValueChanged<MatchActivity> onSelect;

  @override
  Widget build(BuildContext context) {
    const activities = MatchActivity.values;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: activities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.18,
      ),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _ActivityCard(
          activity: activity,
          isSelected: activity == selected,
          onTap: () => onSelect(activity),
        );
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.activity,
    required this.isSelected,
    required this.onTap,
  });

  final MatchActivity activity;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final visual = activityVisual(activity);
    final radius = BorderRadius.circular(16);
    final label = activityLabel(context.l10n, activity);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: visual.background,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: isSelected ? WhereRuBrand.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(visual.icon, size: 26, color: visual.foreground),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
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
