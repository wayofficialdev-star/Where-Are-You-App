import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_someone_repository.g.dart';

@Riverpod(keepAlive: true)
IFindSomeoneRepository findSomeoneRepo(FindSomeoneRepoRef ref) =>
    FindSomeoneRepository();

class FindSomeoneRepository implements IFindSomeoneRepository {
  FindSomeoneRepository();

  // TODO(where-ru): replace with the Supabase proximity search once the
  // backend contract for nearby users is available.
  static const _people = [
    NearbyPerson(
      id: 'person-anagha',
      name: 'Anagha',
      headline: 'Coffee, books and long walks',
      distanceKm: 0.8,
    ),
    NearbyPerson(
      id: 'person-arjun',
      name: 'Arjun',
      headline: 'Morning runs at Marine Drive',
      distanceKm: 1.6,
    ),
    NearbyPerson(
      id: 'person-meera',
      name: 'Meera',
      headline: 'New in Kochi, loves live music',
      distanceKm: 2.4,
    ),
  ];

  @override
  Future<List<NearbyPerson>> search(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return _people;

    return _people
        .where(
          (person) =>
              person.name.toLowerCase().contains(normalized) ||
              person.headline.toLowerCase().contains(normalized),
        )
        .toList();
  }
}
