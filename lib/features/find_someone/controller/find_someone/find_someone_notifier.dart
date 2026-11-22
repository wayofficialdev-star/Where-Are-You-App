import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_someone_notifier.freezed.dart';
part 'find_someone_notifier.g.dart';
part 'find_someone_state.dart';

/// Delay between the simulated matching steps.
///
/// Exposed as a provider so widget tests can run the scan instantly instead of
/// waiting on the animation.
@Riverpod(keepAlive: true)
Duration matchingStepDelay(MatchingStepDelayRef ref) =>
    const Duration(milliseconds: 700);

/// Drives the four-step AI matchmaking flow.
///
/// Everything is local until the backend contract exists: the notifier owns the
/// wizard selections, the simulated scan and the sample match, and never claims
/// a real person was found or connected.
@Riverpod(keepAlive: true)
class FindSomeoneNotifier extends _$FindSomeoneNotifier {
  var _disposed = false;

  @override
  FindSomeoneState build() {
    ref.onDispose(() => _disposed = true);
    return const FindSomeoneState();
  }

  void selectActivity(MatchActivity activity) {
    state = state.copyWith(activity: activity);
  }

  void toggleInterest(MatchInterest interest) {
    final next = {...state.interests};
    if (!next.remove(interest)) next.add(interest);
    state = state.copyWith(interests: next);
  }

  void setDistance(double distanceKm) {
    state = state.copyWith(distanceKm: distanceKm);
  }

  void selectMeetingTime(MeetingTimeOption option) {
    state = state.copyWith(meetingTime: option);
  }

  void setNote(String note) {
    state = state.copyWith(
      note: note.length > kMatchNoteMaxLength
          ? note.substring(0, kMatchNoteMaxLength)
          : note,
    );
  }

  /// Keeps the logical step in sync with the route the user is on.
  void goToStep(FindSomeoneStep step) {
    state = state.copyWith(step: step);
  }

  /// Simulates the AI scan, then asks the repository for a match.
  Future<void> startMatching() async {
    final activity = state.activity;
    if (activity == null || state.isSearching) return;

    state = state.copyWith(
      step: FindSomeoneStep.matching,
      isSearching: true,
      match: null,
      progressStep: 0,
      errorMessage: null,
    );

    final stepDelay = ref.read(matchingStepDelayProvider);

    try {
      for (var step = 1; step <= 3; step++) {
        await Future<void>.delayed(stepDelay);
        if (_disposed) return;
        state = state.copyWith(progressStep: step);
      }

      final match = await ref
          .read(findSomeoneRepoProvider)
          .findMatch(
            MatchPreferences(
              activity: activity,
              interests: state.interests,
              distanceKm: state.distanceKm,
              meetingTime: state.meetingTime,
              note: state.note,
            ),
          );

      if (_disposed) return;
      state = state.copyWith(
        match: match,
        isSearching: false,
        progressStep: 4,
        step: FindSomeoneStep.result,
      );
    } catch (error) {
      if (_disposed) return;
      state = state.copyWith(
        isSearching: false,
        errorMessage: error.toString(),
        step: FindSomeoneStep.preferences,
      );
    }
  }

  /// Clears the previous result but keeps the preferences so a new scan can run
  /// with the same answers.
  void tryAnotherMatch() {
    state = state.copyWith(
      match: null,
      progressStep: 0,
      isSearching: false,
      errorMessage: null,
      step: FindSomeoneStep.matching,
    );
  }
}
