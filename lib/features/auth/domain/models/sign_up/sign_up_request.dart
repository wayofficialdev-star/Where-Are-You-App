import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';

/// Values collected by the sign-up form.
///
/// This is the Flutter-side shape only. The Supabase payload is owned by the
/// backend team, so no JSON mapping is defined until that contract exists.
@freezed
class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    required String fullName,
    required String email,
    required String password,
    @Default('') String location,
  }) = _SignUpRequest;
}
