import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Rounded selectable pill used by the interest and meeting-time pickers.
class SelectableChip extends StatelessWidget {
  const SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.showCheck = true,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  /// Replaces the [icon] with a check mark when selected.
  final bool showCheck;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? WhereRuBrand.blue : WhereRuBrand.navy;
    final radius = BorderRadius.circular(100);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? WhereRuBrand.pastelBlue : AppColors.white,
            borderRadius: radius,
            border: Border.all(
              color: isSelected ? WhereRuBrand.blue : WhereRuBrand.fieldBorder,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 34),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected && showCheck)
                      const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: WhereRuBrand.blue,
                      )
                    else if (icon != null)
                      Icon(
                        icon,
                        size: 14,
                        color: isSelected
                            ? WhereRuBrand.blue
                            : WhereRuBrand.fieldIcon,
                      ),
                    const SizedBox(width: 5),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
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
      ),
    );
  }
}
