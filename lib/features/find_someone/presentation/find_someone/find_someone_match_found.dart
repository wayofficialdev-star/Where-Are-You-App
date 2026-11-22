import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Step 4: the matched person.
class FindSomeoneResultScreen extends ConsumerWidget {
  const FindSomeoneResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(findSomeoneNotifierProvider);
    final notifier = ref.read(findSomeoneNotifierProvider.notifier);
    final l10n = context.l10n;
    final match = state.match;

    if (match == null) {
      return FlowScaffold(
        onBack: () => context.go(AppRouter.findSomeonePath),
        bottomBar: GradientButton(
          label: l10n.findSomeoneCta,
          leadingIcon: Icons.auto_awesome_rounded,
          height: 56,
          fontSize: 17,
          onPressed: () => context.go(AppRouter.findSomeoneFindingPath),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: [
              const Icon(
                Icons.person_search_rounded,
                size: 44,
                color: WhereRuBrand.purple,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.noMatchYet,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: WhereRuBrand.body,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final activity = activityLabel(l10n, match.activity);

    return FlowScaffold(
      onBack: () => context.go(AppRouter.findSomeonePreferencesPath),
      bottomBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The match id doubles as the conversation id, so the chat route can
          // carry it today and receive a real one from the backend later.
          GradientButton(
            label: l10n.connectNow,
            leadingIcon: Icons.people_alt_rounded,
            height: 56,
            fontSize: 17,
            onPressed: () => context.pushNamed(
              AppRouter.chatConversation,
              pathParameters: {'conversationId': match.id},
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              notifier.tryAnotherMatch();
              context.go(AppRouter.findSomeoneFindingPath);
            },
            child: Text(
              l10n.tryAnotherMatch,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: WhereRuBrand.purple,
              ),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SuccessBanner(
            title: l10n.matchFoundTitle,
            subtitle: l10n.matchFoundSubtitle(activity),
          ),
          const SizedBox(height: 14),
          MatchMapPlaceholder(
            distanceKm: match.distanceKm,
            initials: WhereRuBrand.initialsOf(match.name),
          ),
          const SizedBox(height: 14),
          MatchDetailsCard(match: match),
        ],
      ),
    );
  }
}

class _SuccessBanner extends StatelessWidget {
  const _SuccessBanner({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F9F0),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFBFEBD2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFF22C55E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 17,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                    color: WhereRuBrand.navy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                    color: WhereRuBrand.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
