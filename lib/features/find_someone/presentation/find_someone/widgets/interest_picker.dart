import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:app/features/find_someone/presentation/find_someone/widgets/labels.dart';
import 'package:app/features/find_someone/presentation/find_someone/widgets/selectable_chip.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Multi-select interest chips.
class InterestPicker extends StatelessWidget {
  const InterestPicker({
    required this.selected,
    required this.onToggle,
    super.key,
  });

  final Set<MatchInterest> selected;
  final ValueChanged<MatchInterest> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final interest in MatchInterest.values)
          SelectableChip(
            label: interestLabel(context.l10n, interest),
            icon: interestIcon(interest),
            isSelected: selected.contains(interest),
            onTap: () => onToggle(interest),
          ),
      ],
    );
  }
}

/// Single-select meeting time chips.
class MeetingTimePicker extends StatelessWidget {
  const MeetingTimePicker({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final MeetingTimeOption selected;
  final ValueChanged<MeetingTimeOption> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final option in MeetingTimeOption.values)
          SelectableChip(
            label: meetingTimeLabel(context.l10n, option),
            icon: meetingTimeIcon(option),
            isSelected: option == selected,
            onTap: () => onSelect(option),
          ),
      ],
    );
  }
}
