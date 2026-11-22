/// Outcome of a sign-up attempt.
///
/// Authentication is not wired to Supabase yet, so the only possible answer is
/// [backendUnavailable]. Real cases (`created`, `failed`, …) belong here once
/// the backend contract lands — never treat the placeholder as a success.
enum SignUpResult { backendUnavailable }
