import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Primary Where RU action: find someone who wants the same thing right now.
class MatchCtaCard extends StatelessWidget {
  const MatchCtaCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isCompact = true,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(isCompact ? 22 : 26);

    return Semantics(
      button: true,
      label: title,
      child: ClipRRect(
        borderRadius: radius,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: WhereRuBrand.ctaGradient,
              borderRadius: radius,
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: Stack(
                children: [
                  // Decorative city/palm cue from the reference. The
                  // production illustration is not in the asset set yet, so
                  // this stays a low-contrast icon rather than new artwork.
                  Positioned(
                    right: -12,
                    bottom: -16,
                    child: Icon(
                      Icons.location_city_rounded,
                      size: isCompact ? 104 : 122,
                      color: AppColors.white.withValues(alpha: .12),
                    ),
                  ),
                  Positioned(
                    right: isCompact ? 26 : 34,
                    bottom: 4,
                    child: Icon(
                      Icons.park_rounded,
                      size: isCompact ? 34 : 42,
                      color: AppColors.white.withValues(alpha: .14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isCompact ? 16 : 20,
                      vertical: isCompact ? 16 : 20,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: isCompact ? 46 : 54,
                          height: isCompact ? 46 : 54,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: .18),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white.withValues(alpha: .35),
                            ),
                          ),
                          child: Icon(
                            Icons.person_search_rounded,
                            size: isCompact ? 24 : 28,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: isCompact ? 12 : 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: isCompact ? 21 : 24,
                                        fontWeight: FontWeight.w800,
                                        height: 1.15,
                                        letterSpacing: -.4,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: isCompact ? 20 : 22,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                subtitle,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: isCompact ? 12 : 13.5,
                                  fontWeight: FontWeight.w400,
                                  height: 1.45,
                                  color: AppColors.white.withValues(alpha: .9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
