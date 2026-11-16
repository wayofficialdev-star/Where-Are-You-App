# AGENTS.md

Permanent rules for this repository. Read before changing code.

## Architecture — do not replace

- **State management: Riverpod only.** `flutter_riverpod` + `riverpod_annotation`
  (`@riverpod` / `Notifier` / `AsyncNotifier`). No Bloc, GetX, Provider or
  `setState`-driven app state.
- **Navigation: GoRouter only**, configured in `lib/shared/utils/router.dart`
  with the `ShellRoute` shell (`lib/shared/widgets/app_shell.dart`).
- **Keep the three flavors**: `development`, `staging`, `production`
  (`lib/main_*.dart`, `lib/env.dart`, Android product flavors, Xcode
  configurations, `.vscode/launch.json`).
- **Keep the feature-first layout**: `lib/features/<feature>/{controller,domain,presentation}`.
  Shared models live in `lib/shared/models`.
- **Use the existing `home` feature.** Do not create a second Home feature.
- **Theme: Hancod Theme** (`hancod_theme`) plus `WhereRuBrand` in
  `lib/shared/utils/brand.dart`. Do not introduce a parallel theme system.
- Preserve the existing starter infrastructure: connectivity, SharedPreferences,
  locale, responsive layout, force update (Upgrader), deep linking, PDF.

## Backend

- **Supabase is the backend.** Keep the `supabase_provider` architecture.
- **Backend contracts come from the backend team.** Never invent tables,
  columns, RPCs, RLS policies, buckets or response shapes.
- Feature repositories currently return placeholder data marked
  `// TODO(where-ru)`. When the contract arrives, replace only repository method
  bodies; notifiers and screens stay unchanged.
- Supabase URL/key stay build-time configuration (`--dart-define`).

## Secrets — never commit

- Firebase config: `GoogleService-Info.plist`, `google-services.json`
  (Firebase is used for push notifications, Analytics and Crashlytics).
- Signing material: `key.properties`, `*.jks`, `*.keystore`, `*.p12`, `*.pem`,
  `*.cer`, `*.csr`, `*.mobileprovision`.
- `.env` / `.env.*`, and `.freebuff/` (local agent state).
- Never hard-code API keys, tokens or service-role keys in source.

## Workflow

- Generate code after changing models or providers:
  `dart run build_runner build -d`
- Localization: edit `lib/l10n/arb/*.arb`, then `flutter gen-l10n` (generated
  files in `lib/l10n/gen` are committed).
- Run `flutter analyze` and `flutter test` before handing work over.
- Do not change architecture, package structure or bundle identifiers without
  explicit approval.
