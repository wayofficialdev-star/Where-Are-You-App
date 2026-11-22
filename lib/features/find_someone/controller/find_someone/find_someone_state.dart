part of 'find_someone_notifier.dart';

/// Logical step of the matchmaking flow. The GoRouter location mirrors this so
/// deep links and the wizard cannot drift apart.
enum FindSomeoneStep { activity, preferences, matching, result }

@freezed
class FindSomeoneState with _$FindSomeoneState {
  const factory FindSomeoneState({
    @Default(FindSomeoneStep.activity) FindSomeoneStep step,
    MatchActivity? activity,
    @Default(<MatchInterest>{}) Set<MatchInterest> interests,
    @Default(10) double distanceKm,
    @Default(MeetingTimeOption.now) MeetingTimeOption meetingTime,
    @Default('') String note,
    @Default(0) int progressStep,
    @Default(false) bool isSearching,
    MatchedPerson? match,
    String? errorMessage,

    // TODO(where-ru): read the signed-in display name from the profile
    // repository once auth exposes it to this feature.
    @Default('Krishnan') String userName,
  }) = _FindSomeoneState;

  const FindSomeoneState._();

  /// The activity is the only required answer before moving on.
  bool get canContinue => activity != null && interests.isNotEmpty;

  bool get hasResult => match != null && !isSearching;
}
