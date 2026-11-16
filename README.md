# Where RU

[![License: MIT][license_badge]][license_link]

---

# 🚀 Where RU Flutter application

**Where RU** is a Flutter application for finding people around you and
starting your next meeting. It is built on the Hancod Flutter starter template,
so the architecture described below — Riverpod, GoRouter, flavors, Supabase,
Firebase, theming, localization and code generation — is the project's
foundation. Reuse and extend it rather than replacing it.

## Current status

- The Dart layer is Where RU-shaped. Each feature repository still returns
  clearly marked placeholder data (`// TODO(where-ru)`) until the Supabase
  contract is published.
- Firebase is wired in but not configured. The app builds and runs without any
  Firebase configuration file; Analytics and Crashlytics stay inactive until the
  Where RU files are supplied (see **Firebase Configuration**).
- Supabase credentials are build-time only (`--dart-define`), never committed.

The original template introduction is kept below because its conventions still
apply to this project.

## 🧱 Starter template overview

Welcome to the **Flutter Starter Template**! This project is designed to
kickstart your Flutter apps with best practices and built-in support for
**Riverpod**, **Supabase**, and **go_router**. Whether you're building for
**iOS**, **Android**, **Web**, **Windows**, **Linux**, or **MacOS**, this
template has you covered. Let's dive in! 😄

## 🛠 Getting Started

This template is pinned to **Flutter 3.41.2 / Dart 3.11** (`flutter --version`). Use
the same SDK for local development and CI so generated code stays consistent.

This template supports three flavors:

- **Development**
- **Staging**
- **Production**

To run the desired flavor, either use the launch configuration in VSCode/Android
Studio or execute the following commands:

```bash
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

> **Note**: If you're using packages like `flutter_iconpicker`, add the argument
> `--no-tree-shake-icons` after generating the icon pack.

### Environment configuration

Supabase and IPInfo credentials are **not** stored in source control. Pass them
at build time:

```bash
flutter run --flavor development --target lib/main_development.dart \
  --dart-define=SERVER_URL=https://<project>.supabase.co \
  --dart-define=ANON_KEY=<anon-key> \
  --dart-define=IPINFO_TOKEN=<token>
```

`--dart-define-from-file=<path>.json` works too. When a value is missing the app
still starts: the IP lookup is skipped and Supabase simply has no backend until
the values are supplied.

Generate sources after cloning or after changing models/providers:

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build -d
```

`.g.dart` and `.freezed.dart` files are intentionally git-ignored, so this step
is required on a fresh clone and in CI.

### Platform Support

This project is enabled for **iOS**, **Android**, **Web**, **Windows**,
**Linux**, and **MacOS**. However, flavors are currently supported only on
**iOS**, **Android**, and **MacOS**.

## 🌐 Working with Translations

We rely on [flutter_localizations][flutter_localizations_link] and follow the
[official internationalization guide for Flutter][internationalization_link].
For a smooth workflow, we use the **L10nization** package developed by
_lsaudon_.

### Adding Translations

To add translations:

1. Select the string in your code.
2. Use the "Extract value to ARB files" action.

Use `context.l10n` or `Approuter.l10n` to access the generated translations.

For each supported locale, add a new ARB file in `lib/l10n/arb`.

Update the `CFBundleLocalizations` array in the `Info.plist` at
`ios/Runner/Info.plist` to include the new locale.

```bash
# Generate localization files (configured by l10n.yaml)
flutter gen-l10n
```

Generated localizations live in `lib/l10n/gen` and are imported through
`context.l10n`. They are committed, so a fresh clone builds without running
`gen-l10n`; regenerate them whenever an ARB file changes.

## 🎁 Features

This template comes with several inbuilt features:

- Internet connectivity checker
- Environment setup in Flutter & native flavor setup
- Facebook App Events
- Firebase Analytics & Crashlytics
- IPInfo (for country-specific UX like phone number initial code, currency,
  etc.)
- Locale setup
- Platform-dependent PDF/printing setup
- Router config
- Shared Preferences config
- Supabase integration
- Theming setup
- DateTime utils
- Custom extensions
- Responsive layout widget (for adaptive UI)
- Force update feature

## 🧭 Where RU screens and data flow

The app keeps the feature-first layout:
`lib/features/<feature>/{controller,domain,presentation}`.

- `home` — Where RU dashboard (header, FIND SOMEONE, level/XP card, meeting
  history preview)
- `find_someone` — search for people nearby
- `meetings` — full meeting history
- `profile` — level, XP and coins

Navigation is a `ShellRoute` in `lib/shared/utils/router.dart` (bottom bar on
phones, navigation rail on wide layouts) with the four destinations above.
Models shared by more than one feature live in `lib/shared/models`
(`UserProfile`, `Meeting`).

> **Backend status**: each feature repository returns clearly marked placeholder
data (`// TODO(where-ru)`) until the Supabase contract is published. When it is
available, replace only the repository method bodies; notifiers and screens stay
unchanged.

## 🚫 Never commit

These files are git-ignored and must never enter the repository:

- `ios/Runner/<flavor>/GoogleService-Info.plist`
- `android/app/src/<flavor>/google-services.json`
- `android/key.properties` and any `*.jks` / `*.keystore`
- `*.p12`, `*.pem`, `*.cer`, `*.csr`, `*.mobileprovision`
- `.env` and `.env.*`
- `.freebuff/` (local agent state)
- `build/`, `.dart_tool/`, and generated `*.g.dart` / `*.freezed.dart`

Firebase configuration for Where RU is supplied separately by the team. The
project intentionally builds and runs without it.

## 🔥 Firebase Configuration

This project is already set up for development and production Firebase
configurations. Firebase is required for **push notifications**, **Analytics**
and **Crashlytics**; none of those configuration files are committed.

### Android

Copy the `google-services.json` file to the respective flavor folder:

- For development: `app/src/development`
- For staging: `app/src/staging`
- For production: `app/src/production`

The `google-services` and `crashlytics` Gradle plugins are applied only when at
least one of those files exists, so the app builds without Firebase configured.
Add the files to enable Analytics/Crashlytics.

### iOS

Copy `GoogleService-Info.plist` to `ios/Runner/${flavor}` (development, staging,
production). The copy build phase picks the file for the selected
configuration and skips the copy when it is absent.

### Web

No additional configuration is required.

### Deploying Web Builds

For deploying to different environments, you can build to separate folders:

```bash
flutter build web -t lib/main_development.dart --no-tree-shake-icons -o 'build/web/development'
firebase deploy -P dev --only hosting:dev

flutter build web -t lib/main_production.dart --no-tree-shake-icons -o 'build/web/production'
firebase deploy -P prod --only hosting:prod
```

Make sure to update `firebase.json`, `.firebaserc`, and add the respective
`google_services.json` and `GoogleService-Info.plist` for Firebase
Crashlytics/Analytics to work properly.

## 🌐 Deeplinking

Deeplinking has already been configured:

- `web/.well-known/app.html` can navigate to respective store pages.
- `web/.well-known/apple-app-site-association` and
  `web/.well-known/assetlinks.json` are needed for iOS and Android deeplinking,
  respectively.
- `web/example.upgrader.xml` is the upgrader config file to enforce mandatory or
  optional updates.

## 🎨 Branding placeholders

The launcher icons and splash images still ship the starter artwork (the Hancod
"H" mark, plus a generic macOS placeholder icon). This is **not** the Where RU
brand.

**PLACEHOLDER — REPLACE WITH WHERE RU BRAND ASSETS** in:

- `android/app/src/*/res/mipmap-*` and `res/drawable/ic_launcher_foreground.xml`
- `ios/Runner/Assets.xcassets/AppIcon*` and `LaunchImage*`
- `macos/Runner/Assets.xcassets/AppIcon*`
- `web/favicon.png` and `web/icons/*`
- `windows/runner/resources/app_icon.ico`

Do not use `flutter_launcher_icons`; follow the platform icon guidelines below.

## 🧾 Identity placeholders (pending approval)

These values are deliberately still the template placeholders because the final
Where RU values have not been approved yet. Do not invent them:

- Dart package name: `app` (`pubspec.yaml`) — renaming to `where_ru` rewrites
  every `package:app/...` import, so it is deferred.
- Android `applicationId` / `namespace` and iOS/macOS bundle identifiers:
  `com.example.app`, `com.example.app.dev`, `com.example.app.stg`,
  `com.example.myApp*`.
- Apple `DEVELOPMENT_TEAM`: intentionally unset.
- `web/.well-known/apple-app-site-association` (`TEAM_ID_PENDING`),
  `web/.well-known/assetlinks.json` (empty fingerprint list),
  `web/.well-known/app.html` and `web/example.upgrader.xml` (store URLs).
- `.firebaserc` project ids and hosting site ids.

`lib/app/view/app.dart` keeps `appcastURL` empty until a force-update feed
exists.

## 📦 Freezed for Model Class Generation

To generate model classes, use:

```bash
dart run build_runner build -d  # -d deletes conflicts
```

> **Warning**: Please avoid using `flutter_launcher_icons`. For high-quality
> icons, follow the respective platform documentation.

- [Android Icon Design](https://developer.android.com/develop/ui/views/launch/icon_design_adaptive)
- [iOS Icon Design](https://developer.apple.com/design/human-interface-guidelines/app-icons)

## 🔍 Linting and Analysis

Please try to keep lint warnings and analysis issues to a minimum. 🙏

## 🚀 Hancod Tools

At **Hancod**, we've built a VSCode extension to make your life easier! 🎉

- **Name**: Hancod Riverpod Generator
- **Id**: Hancod.hancod-rivepod
- **Description**: Generate Flutter Riverpod boilerplate code for features
- **Version**: 0.0.1
- **Publisher**: Hancod

### Features

- Automatic directory creation
- Boilerplate code generation for:
  - Repositories
  - Models
  - State Management
  - Notifiers
  - Screens

Right-click on the features folder to create a new module, directory, or
boilerplate code.

## 📦 Hancod Theme Package

We've also created a Flutter package for rapid development of components like
buttons, forms, themes, etc.

### How to Use

1. Create a separate branch for your specific project.
2. Customize it for your needs.
3. Add the package to your dependencies:

```yaml
dependencies:
  hancod_theme:
    git:
      url: https://github.com/Hancod-Digital/hancod_theme.git
      ref: your-project-branch
```

For more information, check the package's
[README.md](https://github.com/alfas-hancod/hancod_theme).

---

This template is designed to save you time and effort, so you can focus on what
matters most—building amazing apps! Happy coding! 🎉

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT

---
