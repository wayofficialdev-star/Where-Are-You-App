import 'package:app/features/meetings/domain/meetings_domain.dart';
import 'package:app/shared/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meetings_repository.g.dart';

@Riverpod(keepAlive: true)
IMeetingsRepository meetingsRepo(MeetingsRepoRef ref) => MeetingsRepository();

class MeetingsRepository implements IMeetingsRepository {
  MeetingsRepository();

  // TODO(where-ru): replace with the Supabase meetings query once the backend
  // contract is available. Keep the model shape in sync with the home preview.
  @override
  Future<List<Meeting>> fetchMeetings() async => [
    Meeting(
      id: 'meeting-anagha',
      name: 'Anagha',
      activity: 'Tea/Coffee',
      date: DateTime(2026, 10, 12),
      location: 'Lulu Mall, Kochi',
    ),
    Meeting(
      id: 'meeting-arjun',
      name: 'Arjun',
      activity: 'Walks',
      date: DateTime(2026, 10, 5),
      location: 'Marine Drive, Kochi',
    ),
  ];
}
