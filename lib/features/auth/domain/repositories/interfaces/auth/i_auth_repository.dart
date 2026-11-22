import 'package:app/features/auth/domain/auth_domain.dart';

// A single-operation port mirrors the repository convention used by the other
// features; the style rule that prefers a function type would break it.
// ignore: one_member_abstracts
abstract interface class IAuthRepository {
  /// Attempts to create an account from [request].
  Future<SignUpResult> signUp(SignUpRequest request);
}
