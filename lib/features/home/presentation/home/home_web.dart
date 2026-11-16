import 'package:app/features/home/home.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

class HomeScreenWeb extends ConsumerWidget {
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: home.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(
            child: Text(
              context.l10n.somethingWentWrong,
              style: AppText.mediumN.copyWith(color: AppColors.stormyBlue),
            ),
          ),
          data: (state) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 40),
                children: [
                  HomeHeader(displayName: state.profile.displayName),
                  const SizedBox(height: 28),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            FindSomeoneCard(
                              onFind: () =>
                                  context.go(AppRouter.findSomeonePath),
                            ),
                            const SizedBox(height: 20),
                            MeetingHistory(meetings: state.meetings),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 2,
                        child: ProfileProgressCard(profile: state.profile),
                      ),
                    ],
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
