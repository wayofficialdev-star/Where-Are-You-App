import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Step 2: distance, meeting time and the optional note.
class FindSomeonePreferencesScreen extends ConsumerWidget {
  const FindSomeonePreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(findSomeoneNotifierProvider);
    final notifier = ref.read(findSomeoneNotifierProvider.notifier);
    final l10n = context.l10n;

    return FlowScaffold(
      onBack: () {
        notifier.goToStep(FindSomeoneStep.activity);
        context.go(AppRouter.findSomeonePath);
      },
      bottomBar: GradientButton(
        label: l10n.findSomeoneCta,
        leadingIcon: Icons.auto_awesome_rounded,
        height: 56,
        fontSize: 17,
        onPressed: () {
          notifier.goToStep(FindSomeoneStep.matching);
          context.go(AppRouter.findSomeoneFindingPath);
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AssistantMessage(l10n.aiDistancePrompt),
          const SizedBox(height: 12),
          DistanceSelector(
            distanceKm: state.distanceKm,
            onChanged: notifier.setDistance,
          ),
          const SizedBox(height: 18),
          AssistantMessage(l10n.aiTimePrompt),
          const SizedBox(height: 12),
          MeetingTimePicker(
            selected: state.meetingTime,
            onSelect: notifier.selectMeetingTime,
          ),
          const SizedBox(height: 18),
          AssistantMessage(l10n.aiNotePrompt),
          const SizedBox(height: 12),
          NoteField(initialValue: state.note, onChanged: notifier.setNote),
        ],
      ),
    );
  }
}
