import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Progress summary for the signed-in Where RU user.
///
/// Shared between the home dashboard and the profile screen; backed by the
/// Supabase profile contract once it is available.
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default('') String displayName,
    @Default(1) int level,
    @Default('Newcomer') String levelTitle,
    @Default(0) int xp,
    @Default(0) int coins,
    @Default(0) int xpToNextLevel,
    String? avatarUrl,
  }) = _UserProfile;

  const UserProfile._();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Progress towards the next level (0 - 1), safe when no XP is known.
  double get levelProgress {
    final total = xp + xpToNextLevel;
    if (total <= 0) return 0;
    return (xp / total).clamp(0.0, 1.0);
  }
}
