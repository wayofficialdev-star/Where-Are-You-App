# Flutter Template Guide

How the reusable starter in this repository is put together, and how to work
with it. Where RU is the current application built on top of it.

## Layers

```
lib/
  app/                 MaterialApp.router, theme, force update
  bootstrap.dart       ProviderScope + observer bootstrap
  env.dart             IEnvironment (+ Environment implementations)
  main_<flavor>.dart   entrypoints: runApp(App(environment: ...))
  features/<feature>/  controller/ (notifiers) · domain/ (models + repos) · presentation/
  shared/              providers · widgets · utils · models · l10n helpers
  l10n/                arb sources + generated localizations
```

`domain` never imports `presentation`; `presentation` reads state through
providers only.

## Flavors and environment

| Flavor | Entrypoint | iOS/macOS config | Android suffix |
|---|---|---|---|
| development | `lib/main_development.dart` | Development | `.dev` |
| staging | `lib/main_staging.dart` | Development + staging plist | `.stg` |
| production | `lib/main_production.dart` | Production | none |

Everything environment-specific flows through `IEnvironment` and
`String.fromEnvironment` — nothing is hard-coded:

```bash
flutter run --flavor development --target lib/main_development.dart \
  --dart-define=SERVER_URL=... --dart-define=ANON_KEY=... --dart-define=IPINFO_TOKEN=...
```

## State management

Riverpod with code generation:

- `@riverpod` functions for simple values,
- `Notifier` / `AsyncNotifier` subclasses for feature state,
- repository providers are generated, implementations stay behind interfaces so
  the backend can be swapped without touching UI.

`bootstrap.dart` installs a `ProviderObserver` for logging; `ProviderScope`
overrides live there, not in widgets.

## Navigation

Single `GoRouter` built in `lib/shared/utils/router.dart`, exposing
`goNamed`, `pushNamed` and `pop` helpers. `ShellRoute` hosts `AppShell`, which
switches between a bottom bar (compact) and navigation rail (wide) using
`ResponsiveLayout`.

Auth gating is a `ValueNotifier` redirect hook — currently disabled until the
backend contract exists.

## Theming

`hancod_theme` provides `AppColors`, `AppText`, `AppStyles` and components.
Where RU accents (gradient, pastels, card decoration) are additive and isolated
in `lib/shared/utils/brand.dart`.

## Localization

ARB files in `lib/l10n/arb`, generated into `lib/l10n/gen` and accessed with
`context.l10n`. `l10n.yaml` drives generation. Generated localizations are
committed; `*.g.dart` / `*.freezed.dart` are not.

## Firebase

Flavor-aware and optional:

- Android applies the `google-services` and `crashlytics` Gradle plugins only
  when a `google-services.json` exists.
- iOS copies `ios/Runner/<flavor>/GoogleService-Info.plist` through a build
  phase that skips silently when the file is absent.
- Dart side: `firebase_options_<flavor>.dart` hold placeholders; providers for
  Analytics/Crashlytics/push are already wired.

So the repository always builds without Firebase. Supply the real files
locally or through CI secrets — never commit them.

## Supabase

`supabase_provider` initializes `Supabase` from `envProvider`. Feature
repositories depend on the client through generated providers, so swapping in
the real contract only changes repository bodies.

## Quality gates

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build -d
flutter analyze
flutter test
flutter build web -t lib/main_development.dart
```

CI (`.github/workflows/main.yaml`) runs localization + build_runner before
analyze/test.

## Conventions checklist

- New feature → new folder under `lib/features`, never a second copy of an
  existing one.
- Shared model → `lib/shared/models`; feature-only model → feature `domain`.
- Never call Supabase/Firebase directly from a widget.
- Keep platform display names driven by `appName` (Android) and
  `FLAVOR_APP_NAME` (iOS/macOS) placeholders.
- Branding assets (icons/splash) are placeholders until Where RU art lands.
