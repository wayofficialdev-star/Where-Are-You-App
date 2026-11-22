import 'package:app/features/home/home.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// "When" filters. Scrolls horizontally so the pills never overflow on phones.
class TimeFilterRow extends StatelessWidget {
  const TimeFilterRow({
    required this.selected,
    required this.onSelected,
    this.isCompact = true,
    super.key,
  });

  final HomeFilter selected;
  final ValueChanged<HomeFilter> onSelected;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = <(HomeFilter, String, IconData)>[
      (HomeFilter.rightNow, l10n.rightNow, Icons.bolt_rounded),
      (HomeFilter.withinOneHour, l10n.withinOneHour, Icons.schedule_rounded),
      (HomeFilter.laterToday, l10n.laterToday, Icons.calendar_today_rounded),
      (HomeFilter.scheduledTime, l10n.scheduledTime, Icons.event_note_rounded),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _FilterPill(
                label: item.$2,
                icon: item.$3,
                isSelected: item.$1 == selected,
                isCompact: isCompact,
                onTap: () => onSelected(item.$1),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isCompact,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(100);
    final foreground = isSelected ? AppColors.white : WhereRuBrand.navy;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: isSelected ? WhereRuBrand.selectedPillGradient : null,
            color: isSelected ? null : AppColors.white,
            borderRadius: radius,
            border: isSelected
                ? null
                : Border.all(color: WhereRuBrand.fieldBorder),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 6),
                blurRadius: isSelected ? 18 : 12,
                color: isSelected
                    ? const Color(0xFF5B58F0).withValues(alpha: .28)
                    : WhereRuBrand.navy.withValues(alpha: .05),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 12 : 14,
                vertical: isCompact ? 9 : 11,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: isCompact ? 15 : 16,
                    color: isSelected
                        ? AppColors.white
                        : WhereRuBrand.fieldIcon,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: isCompact ? 12 : 13.5,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: foreground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
