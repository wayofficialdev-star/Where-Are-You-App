import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:app/features/find_someone/presentation/find_someone/widgets/labels.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Name, distance, activity, availability and shared interests of the match.
class MatchDetailsCard extends StatelessWidget {
  const MatchDetailsCard({required this.match, super.key});

  final MatchedPerson match;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final activity = activityLabel(l10n, match.activity);
    final availability = match.availability.isNotEmpty
        ? match.availability
        : meetingTimeLabel(l10n, match.meetingTime);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: WhereRuBrand.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: WhereRuBrand.pastelFor(match.name),
                child: Text(
                  WhereRuBrand.initialsOf(match.name),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: WhereRuBrand.purple,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: WhereRuBrand.navy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.ageCityLine(match.age, match.city),
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                        color: WhereRuBrand.body,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.near_me_rounded,
                          size: 12,
                          color: WhereRuBrand.blue,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          l10n.approxDistanceAway(match.distanceKm),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: WhereRuBrand.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: activityVisual(match.activity).icon,
                    title: l10n.wantsToGoFor,
                    value: activity,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.schedule_rounded,
                    value: availability,
                  ),
                ),
              ],
            ),
          ),
          if (match.interests.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              l10n.commonInterests,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: WhereRuBrand.navy,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final interest in match.interests)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: WhereRuBrand.fieldBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          interestIcon(interest),
                          size: 12,
                          color: WhereRuBrand.blue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          interestLabel(l10n, interest),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: WhereRuBrand.navy,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.value, this.title});

  final IconData icon;
  final String value;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: WhereRuBrand.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: WhereRuBrand.blue),
              if (title != null) ...[
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: WhereRuBrand.hint,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.25,
              color: WhereRuBrand.navy,
            ),
          ),
        ],
      ),
    );
  }
}
