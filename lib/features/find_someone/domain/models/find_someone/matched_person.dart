import 'package:app/features/find_someone/domain/models/find_someone/match_activity.dart';
import 'package:app/features/find_someone/domain/models/find_someone/match_interest.dart';
import 'package:app/features/find_someone/domain/models/find_someone/meeting_time_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'matched_person.freezed.dart';

/// The person the AI matched the current user with.
///
/// Locations are intentionally approximate: the contract exposes distance only,
/// never coordinates, so no exact position can leak into the UI.
@freezed
class MatchedPerson with _$MatchedPerson {
  const factory MatchedPerson({
    required String id,
    required String name,
    required int age,
    required String city,
    required double distanceKm,
    required MatchActivity activity,
    required MeetingTimeOption meetingTime,

    /// Human-readable availability from the match, e.g. "Today, Evening".
    @Default('') String availability,
    @Default(<MatchInterest>{}) Set<MatchInterest> interests,
    String? avatarUrl,
  }) = _MatchedPerson;
}
