import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Recent meetings shown on the home page.
class MeetingHistory extends StatelessWidget {
  const MeetingHistory({required this.meetings, super.key});

  final List<Meeting> meetings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.meetingHistory,
                style: AppText.mediumSB.copyWith(color: WhereRuBrand.navy),
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRouter.meetingsPath),
              child: Text(
                context.l10n.seeAll,
                style: AppText.xSmallSB.copyWith(color: WhereRuBrand.purple),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (meetings.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: WhereRuBrand.cardDecoration(),
            child: Text(
              context.l10n.noMeetingsYet,
              textAlign: TextAlign.center,
              style: AppText.smallN.copyWith(color: AppColors.stormyBlue),
            ),
          )
        else
          for (final meeting in meetings.take(3))
            _MeetingTile(meeting: meeting),
      ],
    );
  }
}

class _MeetingTile extends StatelessWidget {
  const _MeetingTile({required this.meeting});

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: WhereRuBrand.cardDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: WhereRuBrand.pastelFor(meeting.name),
            child: Text(
              WhereRuBrand.initialsOf(meeting.name),
              style: AppText.mediumB.copyWith(color: WhereRuBrand.purple),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        meeting.name,
                        style: AppText.mediumSB.copyWith(
                          color: WhereRuBrand.navy,
                        ),
                      ),
                    ),
                    Text(
                      meeting.date.toMeetingDate,
                      style: AppText.xSmallN.copyWith(
                        color: AppColors.stormyBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  meeting.activity,
                  style: AppText.smallN.copyWith(color: WhereRuBrand.purple),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      size: 14,
                      color: AppColors.stormyBlue,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        meeting.location,
                        style: AppText.xSmallN.copyWith(
                          color: AppColors.stormyBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
