import 'package:app/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
IAuthRepository authRepo(AuthRepoRef ref) => AuthRepository();

class AuthRepository implements IAuthRepository {
  AuthRepository();

  // TODO(where-ru): replace the body with `supabase.auth.signUp(...)` once the
  // backend team publishes the auth contract. Until then the form honestly
  // reports that the backend is not connected - no fake session is created.
  @override
  Future<SignUpResult> signUp(SignUpRequest request) async =>
      SignUpResult.backendUnavailable;
}
