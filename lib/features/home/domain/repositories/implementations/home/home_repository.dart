import 'package:app/features/home/home.dart';
import 'package:app/shared/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: true)
IHomeRepository homeRepo(HomeRepoRef ref) => HomeRepository();

class HomeRepository implements IHomeRepository {
  HomeRepository();

  // TODO(where-ru): replace these values with Supabase queries once the
  // backend team publishes the profile, summary and meetings contract. The
  // Flutter side already goes through this repository, so only this file
  // changes then.
  @override
  Future<UserProfile> fetchProfile() async => const UserProfile(
    displayName: 'Alex',
    level: 4,
    levelTitle: 'Explorer',
    xp: 750,
    coins: 120,
    xpToNextLevel: 250,
  );

  @override
  Future<List<Meeting>> fetchMeetings() async => [
    Meeting(
      id: 'meeting-sneha-nair',
      name: 'Sneha Nair',
      activity: 'Movies',
      date: DateTime(2026, 10, 12),
      location: 'Lulu Mall, Kochi',
      distanceKm: 2.1,
      rating: 4.5,
    ),
    Meeting(
      id: 'meeting-arjun-menon',
      name: 'Arjun Menon',
      activity: 'Evening Walk',
      date: DateTime(2026, 10, 5),
      location: 'Marine Drive, Kochi',
      distanceKm: 3.5,
      rating: 4,
    ),
  ];

  @override
  Future<HomeSummary> fetchSummary() async =>
      const HomeSummary(meetupCount: 8, score: 4.8);
}
