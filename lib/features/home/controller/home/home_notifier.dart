import 'package:app/features/home/domain/home_domain.dart';
import 'package:app/shared/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.freezed.dart';
part 'home_notifier.g.dart';
part 'home_state.dart';

/// Loads everything the Where RU home page needs.
///
/// The notifier only talks to [IHomeRepository], so the placeholder data can be
/// swapped for Supabase responses without touching the UI.
@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomeState> build() async {
    final repository = ref.watch(homeRepoProvider);
    return _load(repository, HomeFilter.rightNow);
  }

  /// Applies a time-window selection. Presentation only: nothing is queried
  /// until the matching backend exists.
  void selectFilter(HomeFilter filter) {
    final current = state.valueOrNull;
    if (current == null || current.filter == filter) return;
    state = AsyncData(current.copyWith(filter: filter));
  }

  /// Reloads the dashboard, keeping the current data visible while loading.
  Future<void> refresh() async {
    final repository = ref.read(homeRepoProvider);
    final filter = state.valueOrNull?.filter ?? HomeFilter.rightNow;
    state = await AsyncValue.guard(() => _load(repository, filter));
  }

  Future<HomeState> _load(IHomeRepository repository, HomeFilter filter) async {
    final profile = await repository.fetchProfile();
    final summary = await repository.fetchSummary();
    final meetings = await repository.fetchMeetings();

    return HomeState(
      profile: profile,
      meetings: meetings,
      summary: summary,
      filter: filter,
    );
  }
}
