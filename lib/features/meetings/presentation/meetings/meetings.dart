import 'package:app/features/meetings/meetings.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancod_theme/hancod_theme.dart';

class MeetingsScreen extends ConsumerWidget {
  const MeetingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetings = ref.watch(meetingsNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(meetingsNotifierProvider.notifier).refresh(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            children: [
              Text(
                context.l10n.meetings,
                style: AppText.heading4.copyWith(color: WhereRuBrand.navy),
              ),
              const SizedBox(height: 6),
              Text(
                context.l10n.meetingHistory,
                style: AppText.mediumN.copyWith(color: AppColors.stormyBlue),
              ),
              const SizedBox(height: 20),
              ...meetings.when(
                loading: () => [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
                error: (_, __) => [
                  _EmptyState(message: context.l10n.somethingWentWrong),
                ],
                data: (items) {
                  if (items.isEmpty) {
                    return [_EmptyState(message: context.l10n.noMeetingsYet)];
                  }
                  final sorted = [...items]
                    ..sort((a, b) => b.date.compareTo(a.date));
                  return [
                    for (final meeting in sorted)
                      _MeetingCard(meeting: meeting),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeetingCard extends StatelessWidget {
  const _MeetingCard({required this.meeting});

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: WhereRuBrand.cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: AppText.largeSB.copyWith(
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
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: WhereRuBrand.pastelPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    meeting.activity,
                    style: AppText.xSmallSB.copyWith(
                      color: WhereRuBrand.purple,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
                        style: AppText.smallN.copyWith(
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: WhereRuBrand.cardDecoration(),
      child: Column(
        children: [
          const Icon(
            Icons.handshake_outlined,
            size: 40,
            color: WhereRuBrand.purple,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppText.mediumN.copyWith(color: AppColors.stormyBlue),
          ),
        ],
      ),
    );
  }
}
