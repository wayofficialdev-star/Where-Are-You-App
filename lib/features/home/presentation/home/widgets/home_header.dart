import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Where RU branding, notifications and profile access.
class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.displayName, super.key});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: WhereRuBrand.gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.explore_rounded, color: AppColors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Where RU',
                style: AppText.heading5.copyWith(color: WhereRuBrand.navy),
              ),
              const SizedBox(height: 2),
              Text(
                displayName.isEmpty
                    ? context.l10n.home
                    : context.l10n.homeGreeting(displayName),
                style: AppText.smallN.copyWith(color: AppColors.stormyBlue),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: context.l10n.notifications,
          onPressed: () =>
              context.showSnackBar(context.l10n.notificationsEmpty),
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: WhereRuBrand.navy,
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => context.go(AppRouter.profilePath),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: WhereRuBrand.pastelPurple,
            child: Text(
              WhereRuBrand.initialsOf(displayName),
              style: AppText.smallB.copyWith(color: WhereRuBrand.purple),
            ),
          ),
        ),
      ],
    );
  }
}
