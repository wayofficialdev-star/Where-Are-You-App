import 'package:app/features/home/home.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Dashboard content shared by the mobile and web home layouts.
///
/// Layout only: data comes from [HomeNotifier] and every action either routes
/// through [AppRouter] or reports that the backend is not connected.
class HomeBody extends ConsumerWidget {
  const HomeBody({required this.isCompact, super.key});

  final bool isCompact;

  // TODO(where-ru): read from the chat unread counter once messaging exists.
  static const int unreadChats = 2;

  void _notConnected(BuildContext context) {
    context.showSnackBar(context.l10n.backendNotConnected);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeNotifierProvider);
    final l10n = context.l10n;

    return home.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 120),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.somethingWentWrong,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: WhereRuBrand.body),
            ),
            const SizedBox(height: 14),
            AppButton(
              width: 150,
              onPress: () => ref.invalidate(homeNotifierProvider),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
      data: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeHeader(
            displayName: state.profile.displayName,
            unreadChats: unreadChats,
            isCompact: isCompact,
            onChatTap: () => context.go(AppRouter.chatPath),
            onProfileTap: () => context.go(AppRouter.profilePath),
          ),
          SizedBox(height: isCompact ? 14 : 18),
          MatchCtaCard(
            title: l10n.findAMatch,
            subtitle: l10n.findAMatchSubtitle,
            isCompact: isCompact,
            onTap: () => context.go(AppRouter.findSomeonePath),
          ),
          SizedBox(height: isCompact ? 14 : 18),
          TimeFilterRow(
            selected: state.filter,
            isCompact: isCompact,
            onSelected: (filter) =>
                ref.read(homeNotifierProvider.notifier).selectFilter(filter),
          ),
          SizedBox(height: isCompact ? 12 : 16),
          HomeStatsCard(
            coins: state.profile.coins,
            meetupCount: state.summary.meetupCount,
            score: state.summary.score,
            isCompact: isCompact,
            onRedeem: () => _notConnected(context),
          ),
          SizedBox(height: isCompact ? 20 : 26),
          ActivitySection(
            isCompact: isCompact,
            onActivityTap: (_) => context.go(AppRouter.findSomeonePath),
            onSeeAll: () => context.go(AppRouter.findSomeonePath),
          ),
          SizedBox(height: isCompact ? 20 : 26),
          RecentMeetups(
            meetings: state.meetings,
            isCompact: isCompact,
            onViewHistory: () => context.go(AppRouter.meetingsPath),
          ),
          SizedBox(height: isCompact ? 14 : 18),
          SafetyNotice(isCompact: isCompact),
        ],
      ),
    );
  }
}
