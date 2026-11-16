import 'package:app/features/home/home.dart';
import 'package:app/shared/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: true)
IHomeRepository homeRepo(HomeRepoRef ref) => HomeRepository();

class HomeRepository implements IHomeRepository {
  HomeRepository();

  // TODO(where-ru): replace these values with Supabase queries once the
  // backend team publishes the profile/meetings contract. The Flutter side
  // already goes through this repository, so only this file changes then.
  @override
  Future<UserProfile> fetchProfile() async => const UserProfile(
    displayName: 'Aarav',
    level: 4,
    levelTitle: 'Explorer',
    xp: 750,
    coins: 120,
    xpToNextLevel: 250,
  );

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
