import 'package:app/features/profile/domain/profile_domain.dart';
import 'package:app/shared/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_notifier.g.dart';

/// Progress details for the signed-in user.
@Riverpod()
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<UserProfile> build() => ref.watch(profileRepoProvider).fetchProfile();
}
