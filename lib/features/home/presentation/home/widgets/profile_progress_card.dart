import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Level, XP and coins summary for the signed-in user.
class ProfileProgressCard extends StatelessWidget {
  const ProfileProgressCard({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: WhereRuBrand.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${context.l10n.levelLabel(profile.level)} — '
                  '${profile.levelTitle}',
                  style: AppText.mediumSB.copyWith(color: WhereRuBrand.navy),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: WhereRuBrand.pastelBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  context.l10n.coinsValue(profile.coins),
                  style: AppText.xSmallSB.copyWith(color: WhereRuBrand.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: WhereRuBrand.pastelPurple),
                  FractionallySizedBox(
                    widthFactor: profile.levelProgress,
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
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                context.l10n.xpValue(profile.xp),
                style: AppText.smallSB.copyWith(color: WhereRuBrand.purple),
              ),
              const Spacer(),
              Text(
                context.l10n.xpToNextLevel(profile.xpToNextLevel),
                style: AppText.xSmallN.copyWith(color: AppColors.stormyBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
