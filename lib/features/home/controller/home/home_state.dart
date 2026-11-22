part of 'home_notifier.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required UserProfile profile,
    @Default(<Meeting>[]) List<Meeting> meetings,
    @Default(HomeSummary()) HomeSummary summary,
    @Default(HomeFilter.rightNow) HomeFilter filter,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(profile: UserProfile());
}
