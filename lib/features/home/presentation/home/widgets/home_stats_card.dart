import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Coins, meetups and score summary with the redeem shortcut.
class HomeStatsCard extends StatelessWidget {
  const HomeStatsCard({
    required this.coins,
    required this.meetupCount,
    required this.score,
    required this.onRedeem,
    this.isCompact = true,
    super.key,
  });

  final int coins;
  final int meetupCount;
  final double score;
  final VoidCallback onRedeem;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 14,
        vertical: isCompact ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(isCompact ? 18 : 20),
        border: Border.all(color: WhereRuBrand.hairline),
      ),
      child: Row(
        children: [
          _Stat(
            icon: Icons.monetization_on_rounded,
            iconColor: const Color(0xFFF5B301),
            value: '$coins',
            label: l10n.coins,
            isCompact: isCompact,
          ),
          _Divider(isCompact: isCompact),
          _Stat(
            icon: Icons.groups_rounded,
            iconColor: WhereRuBrand.purple,
            value: '$meetupCount',
            label: l10n.meetups,
            isCompact: isCompact,
          ),
          _Divider(isCompact: isCompact),
          _Stat(
            icon: Icons.star_rounded,
            iconColor: WhereRuBrand.star,
            value: score.toStringAsFixed(1),
            label: l10n.score,
            isCompact: isCompact,
          ),
          _Divider(isCompact: isCompact),
          _RedeemPill(
            label: l10n.redeem,
            isCompact: isCompact,
            onTap: onRedeem,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.isCompact,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(icon, size: isCompact ? 18 : 22, color: iconColor),
            SizedBox(width: isCompact ? 4 : 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isCompact ? 16 : 18,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: WhereRuBrand.navy,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: isCompact ? 9.5 : 11,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: WhereRuBrand.hint,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.isCompact});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: isCompact ? 28 : 32,
      margin: EdgeInsets.symmetric(horizontal: isCompact ? 6 : 9),
      color: WhereRuBrand.hairline,
    );
  }
}

class _RedeemPill extends StatelessWidget {
  const _RedeemPill({
    required this.label,
    required this.isCompact,
    required this.onTap,
  });

  final String label;
  final bool isCompact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: WhereRuBrand.pastelPink,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 8 : 10,
              vertical: isCompact ? 6 : 7,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.card_giftcard_rounded,
                  size: isCompact ? 14 : 16,
                  color: WhereRuBrand.reward,
                ),
                SizedBox(width: isCompact ? 3 : 5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: isCompact ? 10 : 11.5,
                    fontWeight: FontWeight.w700,
                    color: WhereRuBrand.reward,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
