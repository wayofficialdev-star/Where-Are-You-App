part of 'sign_up_notifier.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool isSubmitting,
    @Default(true) bool isPasswordObscured,
  }) = _SignUpState;
}
