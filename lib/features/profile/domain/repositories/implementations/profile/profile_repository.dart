import 'package:app/features/profile/domain/profile_domain.dart';
import 'package:app/shared/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
IProfileRepository profileRepo(ProfileRepoRef ref) => ProfileRepository();

class ProfileRepository implements IProfileRepository {
  ProfileRepository();

  // TODO(where-ru): replace with the Supabase profile query once the backend
  // contract is available.
  @override
  Future<UserProfile> fetchProfile() async => const UserProfile(
    displayName: 'Aarav',
    level: 4,
    levelTitle: 'Explorer',
    xp: 750,
    coins: 120,
    xpToNextLevel: 250,
  );
}
