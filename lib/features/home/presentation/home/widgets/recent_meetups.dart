import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Recently completed meetups with distance and rating.
class RecentMeetups extends StatelessWidget {
  const RecentMeetups({
    required this.meetings,
    required this.onViewHistory,
    this.isCompact = true,
    super.key,
  });

  final List<Meeting> meetings;
  final VoidCallback onViewHistory;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.recentMeetups,
                style: TextStyle(
                  fontSize: isCompact ? 18 : 21,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -.3,
                  color: WhereRuBrand.navy,
                ),
              ),
            ),
            InkWell(
              onTap: onViewHistory,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.viewHistory,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: WhereRuBrand.purple,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: WhereRuBrand.purple,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isCompact ? 10 : 12),
        if (meetings.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: WhereRuBrand.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              context.l10n.noMeetingsYet,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.5, color: WhereRuBrand.body),
            ),
          )
        else
          for (final meeting in meetings.take(2))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _MeetupTile(meeting: meeting, isCompact: isCompact),
            ),
      ],
    );
  }
}

class _MeetupTile extends StatelessWidget {
  const _MeetupTile({required this.meeting, required this.isCompact});

  final Meeting meeting;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ratingLabel = meeting.rating >= 4.5
        ? l10n.ratingGreat
        : l10n.ratingGood;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 12,
        vertical: isCompact ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(isCompact ? 16 : 18),
        border: Border.all(color: WhereRuBrand.hairline),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isCompact ? 22 : 24,
            backgroundColor: WhereRuBrand.pastelFor(meeting.name),
            child: Text(
              WhereRuBrand.initialsOf(meeting.name),
              style: TextStyle(
                fontSize: isCompact ? 13 : 14,
                fontWeight: FontWeight.w700,
                color: WhereRuBrand.purple,
              ),
            ),
          ),
          SizedBox(width: isCompact ? 10 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  meeting.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isCompact ? 14 : 15.5,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    color: WhereRuBrand.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      _iconForActivity(meeting.activity),
                      size: isCompact ? 12 : 13,
                      color: WhereRuBrand.purple,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        [
                          meeting.activity,
                          if (meeting.distanceKm > 0)
                            l10n.distanceKm(meeting.distanceKm),
                        ].join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isCompact ? 11.5 : 12.5,
                          fontWeight: FontWeight.w400,
                          color: WhereRuBrand.body,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: isCompact ? 30 : 34,
            margin: EdgeInsets.symmetric(horizontal: isCompact ? 8 : 10),
            color: WhereRuBrand.hairline,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < 5; i++)
                    Icon(
                      Icons.star_rounded,
                      size: isCompact ? 11 : 12,
                      color: i < meeting.rating.floor()
                          ? WhereRuBrand.star
                          : const Color(0xFFE2E5EE),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                l10n.ratingSummary(meeting.rating, ratingLabel),
                style: TextStyle(
                  fontSize: isCompact ? 10.5 : 11.5,
                  fontWeight: FontWeight.w500,
                  color: WhereRuBrand.body,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Maps a sample activity name to an icon until activities become a typed
  /// backend model.
  static IconData _iconForActivity(String activity) {
    final value = activity.toLowerCase();
    if (value.contains('movie')) return Icons.movie_filter_rounded;
    if (value.contains('walk')) return Icons.directions_walk_rounded;
    if (value.contains('study')) return Icons.menu_book_rounded;
    if (value.contains('game') || value.contains('sport')) {
      return Icons.sports_esports_rounded;
    }
    if (value.contains('coffee') ||
        value.contains('tea') ||
        value.contains('cafe')) {
      return Icons.local_cafe_rounded;
    }
    if (value.contains('dinner') || value.contains('food')) {
      return Icons.restaurant_rounded;
    }
    return Icons.celebration_rounded;
  }
}
