import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Primary Where RU action: find someone to meet.
class FindSomeoneCard extends StatelessWidget {
  const FindSomeoneCard({required this.onFind, super.key});

  final VoidCallback onFind;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.findSomeone,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onFind,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              gradient: WhereRuBrand.gradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 14),
                  blurRadius: 26,
                  color: WhereRuBrand.purple.withValues(alpha: .3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.person_search_rounded,
                          color: AppColors.white,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    context.l10n.findSomeone,
                    style: AppText.heading5.copyWith(
                      color: AppColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l10n.findSomeoneSubtitle,
                    style: AppText.smallN.copyWith(
                      color: AppColors.white.withValues(alpha: .9),
                    ),
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
