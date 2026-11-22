import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Step 3: the simulated AI scan.
class FindSomeoneMatchingScreen extends ConsumerStatefulWidget {
  const FindSomeoneMatchingScreen({super.key});

  @override
  ConsumerState<FindSomeoneMatchingScreen> createState() =>
      _FindSomeoneMatchingScreenState();
}

class _FindSomeoneMatchingScreenState
    extends ConsumerState<FindSomeoneMatchingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(findSomeoneNotifierProvider.notifier).startMatching();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(findSomeoneNotifierProvider, (previous, next) {
      if (next.hasResult) {
        context.go(AppRouter.findSomeoneMatchPath);
      }
    });

    final state = ref.watch(findSomeoneNotifierProvider);
    final l10n = context.l10n;
    final activity = state.activity;
    const titleStyle = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      height: 1.25,
      letterSpacing: -.4,
      color: WhereRuBrand.navy,
    );

    return FlowScaffold(
      onBack: () {
        ref
            .read(findSomeoneNotifierProvider.notifier)
            .goToStep(FindSomeoneStep.preferences);
        context.go(AppRouter.findSomeonePreferencesPath);
      },
      child: Column(
        children: [
          const SizedBox(height: 8),
          // The gradient accent must stay on the same line as its lead, and
          // both lines shrink together on very narrow screens.
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Text(
                  l10n.matchingTitleLine1,
                  textAlign: TextAlign.center,
                  style: titleStyle,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.matchingTitleLine2Lead, style: titleStyle),
                    GradientText(
                      l10n.matchingTitleLine2Accent,
                      style: titleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              activity == null
                  ? l10n.matchingSubtitle('')
                  : l10n.matchingSubtitle(activityLabel(l10n, activity)),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: WhereRuBrand.body,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const RadarVisual(size: 260),
          const SizedBox(height: 16),
          MatchingChecklist(
            progressStep: state.progressStep,
            distanceKm: state.distanceKm,
          ),
          if (state.errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              l10n.somethingWentWrong,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: WhereRuBrand.body),
            ),
          ],
        ],
      ),
    );
  }
}
