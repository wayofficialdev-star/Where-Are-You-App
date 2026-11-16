// ignore_for_file: non_constant_identifier_names

/// Per-flavor application configuration.
///
/// Values that differ between environments or that must not live in source
/// control are supplied at build time through `--dart-define` (or
/// `--dart-define-from-file`), for example:
///
/// ```sh
/// flutter run --flavor development --target lib/main_development.dart \
///   --dart-define=SERVER_URL=https://<project>.supabase.co \
///   --dart-define=ANON_KEY=<anon-key> \
///   --dart-define=IPINFO_TOKEN=<token>
/// ```
///
/// When a value is not supplied the app still starts; features that need it
/// degrade gracefully instead of crashing at boot.
abstract class IEnvironment {
  const IEnvironment();
  String get SERVER_URL;
  String get ANON_KEY;
  String get IPINFO_TOKEN;
  Duration get CONNECT_TIMEOUT;
  Duration get RECEIVE_TIMEOUT;
}

class ProductionEnv extends IEnvironment {
  const ProductionEnv();
  @override
  String get SERVER_URL => const String.fromEnvironment('SERVER_URL');
  @override
  String get ANON_KEY => const String.fromEnvironment('ANON_KEY');
  @override
  String get IPINFO_TOKEN => const String.fromEnvironment('IPINFO_TOKEN');
  @override
  Duration get CONNECT_TIMEOUT => const Duration(seconds: 15);
  @override
  Duration get RECEIVE_TIMEOUT => const Duration(seconds: 30);
}

class StagingEnv extends IEnvironment {
  const StagingEnv();
  @override
  String get SERVER_URL => const String.fromEnvironment('SERVER_URL');
  @override
  String get ANON_KEY => const String.fromEnvironment('ANON_KEY');
  @override
  String get IPINFO_TOKEN => const String.fromEnvironment('IPINFO_TOKEN');
  @override
  Duration get CONNECT_TIMEOUT => const Duration(seconds: 15);
  @override
  Duration get RECEIVE_TIMEOUT => const Duration(seconds: 30);
}

class DevelopmentEnv extends IEnvironment {
  const DevelopmentEnv();
  @override
  String get SERVER_URL => const String.fromEnvironment('SERVER_URL');
  @override
  String get ANON_KEY => const String.fromEnvironment('ANON_KEY');
  @override
  String get IPINFO_TOKEN => const String.fromEnvironment('IPINFO_TOKEN');
  @override
  Duration get CONNECT_TIMEOUT => const Duration(seconds: 15);
  @override
  Duration get RECEIVE_TIMEOUT => const Duration(seconds: 30);
}
