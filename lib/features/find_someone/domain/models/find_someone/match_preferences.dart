import 'package:app/features/find_someone/domain/models/find_someone/match_activity.dart';
import 'package:app/features/find_someone/domain/models/find_someone/match_interest.dart';
import 'package:app/features/find_someone/domain/models/find_someone/meeting_time_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_preferences.freezed.dart';

/// Maximum length of the optional free-text note, mirrored by the form field.
const int kMatchNoteMaxLength = 100;

/// Everything the user chooses before the AI looks for a match.
///
/// This is the Flutter-side request shape; the Supabase matchmaking contract is
/// still owned by the backend team, so no JSON mapping is defined yet.
@freezed
class MatchPreferences with _$MatchPreferences {
  const factory MatchPreferences({
    required MatchActivity activity,
    @Default(<MatchInterest>{}) Set<MatchInterest> interests,
    @Default(10) double distanceKm,
    @Default(MeetingTimeOption.now) MeetingTimeOption meetingTime,
    @Default('') String note,
  }) = _MatchPreferences;
}
