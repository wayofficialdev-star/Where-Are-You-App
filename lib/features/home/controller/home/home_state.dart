part of 'home_notifier.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required UserProfile profile,
    @Default(<Meeting>[]) List<Meeting> meetings,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(profile: UserProfile());
}
