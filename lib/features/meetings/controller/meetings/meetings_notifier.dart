import 'package:app/features/meetings/domain/meetings_domain.dart';
import 'package:app/shared/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meetings_notifier.g.dart';

/// Full meeting history for the signed-in user.
@Riverpod()
class MeetingsNotifier extends _$MeetingsNotifier {
  @override
  Future<List<Meeting>> build() =>
      ref.watch(meetingsRepoProvider).fetchMeetings();

  Future<void> refresh() async {
    final repository = ref.read(meetingsRepoProvider);
    state = await AsyncValue.guard(repository.fetchMeetings);
  }
}
