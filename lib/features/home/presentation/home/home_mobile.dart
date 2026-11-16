import 'package:app/features/home/home.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

class HomeScreenMobile extends ConsumerWidget {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: home.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.somethingWentWrong,
                    textAlign: TextAlign.center,
                    style: AppText.mediumN.copyWith(
                      color: AppColors.stormyBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    width: 160,
                    onPress: () => ref.invalidate(homeNotifierProvider),
                    label: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          ),
          data: (state) => RefreshIndicator(
            onRefresh: () => ref.read(homeNotifierProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              children: [
                HomeHeader(displayName: state.profile.displayName),
                const SizedBox(height: 24),
                FindSomeoneCard(
                  onFind: () => context.go(AppRouter.findSomeonePath),
                ),
                const SizedBox(height: 20),
                ProfileProgressCard(profile: state.profile),
                const SizedBox(height: 24),
                MeetingHistory(meetings: state.meetings),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
