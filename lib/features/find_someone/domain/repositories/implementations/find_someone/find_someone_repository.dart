import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_someone_repository.g.dart';

@Riverpod(keepAlive: true)
IFindSomeoneRepository findSomeoneRepo(FindSomeoneRepoRef ref) =>
    FindSomeoneRepository();

class FindSomeoneRepository implements IFindSomeoneRepository {
  FindSomeoneRepository();

  /// Deliberately fake: the AI matchmaking RPC does not exist yet, so this
  /// returns one clearly labelled sample match built from the user's own
  /// preferences. Nothing here pretends to be a real match.
  // TODO(where-ru): replace the body with the Supabase matchmaking RPC
  // (nearby users, availability, interests, distance, match score). The UI only
  // depends on [IFindSomeoneRepository], so nothing else changes then.
  @override
  Future<MatchedPerson> findMatch(MatchPreferences preferences) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));

    return MatchedPerson(
      id: 'match-anagha',
      name: 'Anagha',
      age: 22,
      city: 'Kochi',
      distanceKm: 3.2,
      activity: preferences.activity,
      meetingTime: preferences.meetingTime,
      availability: 'Today, Evening',
      interests: preferences.interests.isEmpty
          ? const {
              MatchInterest.tech,
              MatchInterest.travel,
              MatchInterest.music,
            }
          : preferences.interests,
    );
  }
}
