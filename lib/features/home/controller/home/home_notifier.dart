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

    return HomeState(
      profile: await repository.fetchProfile(),
      meetings: await repository.fetchMeetings(),
    );
  }

  /// Reloads the dashboard, keeping the current data visible while loading.
  Future<void> refresh() async {
    final repository = ref.read(homeRepoProvider);
    state = await AsyncValue.guard(
      () async => HomeState(
        profile: await repository.fetchProfile(),
        meetings: await repository.fetchMeetings(),
      ),
    );
  }
}
