import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Progress rows shown while the AI is looking for a match.
class MatchingChecklist extends StatelessWidget {
  const MatchingChecklist({
    required this.progressStep,
    required this.distanceKm,
    super.key,
  });

  /// 0 = nothing confirmed yet, 3 = all checks done, 4 = match ready.
  final int progressStep;
  final double distanceKm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        _ChecklistRow(
          icon: Icons.groups_rounded,
          label: l10n.matchingStepInterests,
          isDone: progressStep > 0,
        ),
        const SizedBox(height: 8),
        _ChecklistRow(
          icon: Icons.place_rounded,
          label: l10n.matchingStepDistance(distanceKm.round()),
          isDone: progressStep > 1,
        ),
        const SizedBox(height: 8),
        _ChecklistRow(
          icon: Icons.schedule_rounded,
          label: l10n.matchingStepAvailability,
          isDone: progressStep > 2,
        ),
        const SizedBox(height: 8),
        _ChecklistRow(
          icon: Icons.auto_awesome_rounded,
          label: l10n.matchingStepAlmost,
          isDone: progressStep > 3,
          isBusy: progressStep <= 3,
        ),
      ],
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.icon,
    required this.label,
    required this.isDone,
    this.isBusy = false,
  });

  final IconData icon;
  final String label;
  final bool isDone;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: WhereRuBrand.hairline),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isDone ? WhereRuBrand.pastelMint : WhereRuBrand.pastelBlue,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              size: 15,
              color: isDone ? const Color(0xFF22A06B) : WhereRuBrand.blue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: WhereRuBrand.navy,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isBusy)
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: WhereRuBrand.blue,
              ),
            )
          else if (isDone)
            const Icon(
              Icons.check_circle_rounded,
              size: 18,
              color: Color(0xFF22C55E),
            )
          else
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: WhereRuBrand.blue,
              ),
            ),
        ],
      ),
    );
  }
}
