import 'package:app/features/auth/domain/auth_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_notifier.freezed.dart';
part 'sign_up_notifier.g.dart';
part 'sign_up_state.dart';

/// Owns the sign-up form state and forwards submissions to
/// [IAuthRepository].
///
/// Authentication is not connected yet, so a submission can only answer
/// [SignUpResult.backendUnavailable]; nothing here pretends an account was
/// created.
@Riverpod()
class SignUpNotifier extends _$SignUpNotifier {
  @override
  SignUpState build() => const SignUpState();

  /// Shows or hides the password text.
  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordObscured: !state.isPasswordObscured);
  }

  /// Sends [request] to the repository and reports its outcome.
  Future<SignUpResult> submit(SignUpRequest request) async {
    final repository = ref.read(authRepoProvider);
    state = state.copyWith(isSubmitting: true);
    try {
      return await repository.signUp(request);
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }
}
