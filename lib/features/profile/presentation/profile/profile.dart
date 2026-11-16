import 'package:app/features/profile/profile.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancod_theme/hancod_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: profile.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(
            child: Text(
              context.l10n.somethingWentWrong,
              style: AppText.mediumN.copyWith(color: AppColors.stormyBlue),
            ),
          ),
          data: (user) => ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            children: [
              Text(
                context.l10n.profile,
                style: AppText.heading4.copyWith(color: WhereRuBrand.navy),
              ),
              const SizedBox(height: 20),
              _ProfileHero(user: user),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.bolt_rounded,
                      label: context.l10n.xpValue(user.xp),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.toll_rounded,
                      label: context.l10n.coinsValue(user.coins),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _LevelProgress(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: WhereRuBrand.gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 12),
            blurRadius: 24,
            color: WhereRuBrand.purple.withValues(alpha: .25),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white.withValues(alpha: .22),
            child: Text(
              WhereRuBrand.initialsOf(user.displayName),
              style: AppText.heading5.copyWith(color: AppColors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: AppText.heading5.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  '${context.l10n.levelLabel(user.level)} — '
                  '${user.levelTitle}',
                  style: AppText.mediumSB.copyWith(
                    color: AppColors.white.withValues(alpha: .9),
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

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: WhereRuBrand.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: WhereRuBrand.blue),
          const SizedBox(height: 10),
          Text(
            label,
            style: AppText.largeSB.copyWith(color: WhereRuBrand.navy),
          ),
        ],
      ),
    );
  }
}

class _LevelProgress extends StatelessWidget {
  const _LevelProgress({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: WhereRuBrand.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.levelLabel(user.level),
            style: AppText.mediumSB.copyWith(color: WhereRuBrand.navy),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: WhereRuBrand.pastelPurple),
                  FractionallySizedBox(
                    widthFactor: user.levelProgress,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: WhereRuBrand.gradient,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.xpToNextLevel(user.xpToNextLevel),
            style: AppText.smallN.copyWith(color: AppColors.stormyBlue),
          ),
        ],
      ),
    );
  }
}
