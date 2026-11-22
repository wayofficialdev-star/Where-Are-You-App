import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

export 'find_someone_match_found.dart';
export 'find_someone_matching.dart';
export 'find_someone_preferences.dart';
export 'widgets/widgets.dart';

/// Step 1: pick an activity, then the interests to talk about.
class FindSomeoneScreen extends ConsumerWidget {
  const FindSomeoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(findSomeoneNotifierProvider);
    final notifier = ref.read(findSomeoneNotifierProvider.notifier);
    final l10n = context.l10n;
    final activity = state.activity;

    return FlowScaffold(
      bottomBar: GradientButton(
        label: l10n.next,
        height: 56,
        fontSize: 17,
        onPressed: state.canContinue
            ? () {
                notifier.goToStep(FindSomeoneStep.preferences);
                context.go(AppRouter.findSomeonePreferencesPath);
              }
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AssistantMessage(
            '${l10n.aiGreetingTitle(state.userName)}\n${l10n.aiGreetingBody}',
          ),
          const SizedBox(height: 14),
          ActivityPicker(selected: activity, onSelect: notifier.selectActivity),
          if (activity != null) ...[
            const SizedBox(height: 14),
            UserMessage(
              text: activityLabel(l10n, activity),
              displayName: state.userName,
            ),
            const SizedBox(height: 14),
            AssistantMessage(l10n.aiInterestsPrompt),
            const SizedBox(height: 12),
            InterestPicker(
              selected: state.interests,
              onToggle: notifier.toggleInterest,
            ),
          ],
        ],
      ),
    );
  }
}
