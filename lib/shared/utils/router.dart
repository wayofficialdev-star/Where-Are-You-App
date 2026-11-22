import 'package:app/features/auth/auth.dart';
import 'package:app/features/chat/chat.dart';
import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/features/home/home.dart';
import 'package:app/features/meetings/meetings.dart';
import 'package:app/features/profile/profile.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Exposes a [GoRouter] that uses a [Listenable] to refresh its internal state.
///
/// With Riverpod, we can't register a dependency via an Inherited Widget,
/// thus making this implementation the "leanest" possible
///
/// To sync our app state with this our router, we simply update our listenable
/// via `ref.listen`,
/// and pass it to GoRouter's `refreshListenable`.
/// In this example, this will trigger redirects on any authentication change.
///
/// Obviously, more logic could be implemented here, but again, this is meant
/// to be a simple example.
/// You can always build more listenables and even merge more than one
/// into a more complex `ChangeNotifier`,
/// but that's up to your case and out of this scope.

class AppRouter {
  AppRouter(this.ref) {
    ref
      ..onDispose(() {
        authState.dispose();
        router.dispose();
      })
      ..listen(authStateProvider.select((value) => value.asData), (_, next) {
        authState.value = next;
      });
  }
  final authState = ValueNotifier<AsyncValue<AuthState>?>(const AsyncLoading());

  final AppRouterRef ref;

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellKey = GlobalKey<NavigatorState>(
    debugLabel: 'shell',
  );

  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
  static GlobalKey<NavigatorState> get shellKey => _shellKey;

  static BuildContext get rootContext => _rootNavigatorKey.currentContext!;
  static BuildContext get shellContext => _shellKey.currentContext!;

  static AppLocalizations get l10n => rootContext.l10n;

  static const String home = 'home';
  static const String findSomeone = 'findSomeone';
  static const String meetings = 'meetings';
  static const String profile = 'profile';
  static const String splash = 'splash';
  static const String login = 'login';
  static const String signUp = 'signUp';
  static const String findSomeonePreferences = 'findSomeonePreferences';
  static const String findSomeoneFinding = 'findSomeoneFinding';
  static const String findSomeoneMatch = 'findSomeoneMatch';
  static const String chat = 'chat';
  static const String chatConversation = 'chatConversation';

  static const String homePath = '/';
  static const String findSomeonePath = '/find-someone';
  static const String meetingsPath = '/meetings';
  static const String profilePath = '/profile';
  static const String loginPath = '/login';
  static const String signUpPath = '/sign-up';
  static const String findSomeonePreferencesPath = '/find-someone/preferences';
  static const String findSomeoneFindingPath = '/find-someone/finding';
  static const String findSomeoneMatchPath = '/find-someone/match';
  static const String chatPath = '/chat';
  static const String chatConversationPath = '/chat/:conversationId';

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (context, state, child) =>
            AppShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: homePath,
            name: home,
            builder: (context, state) => const HomeScreen(),
          ),
          // The four matchmaking steps are nested under the shell so the
          // Matches destination stays available while the flow is open.
          GoRoute(
            path: findSomeonePath,
            name: findSomeone,
            builder: (context, state) => const FindSomeoneScreen(),
            routes: [
              GoRoute(
                path: 'preferences',
                name: findSomeonePreferences,
                builder: (context, state) =>
                    const FindSomeonePreferencesScreen(),
              ),
              GoRoute(
                path: 'finding',
                name: findSomeoneFinding,
                builder: (context, state) => const FindSomeoneMatchingScreen(),
              ),
              GoRoute(
                path: 'match',
                name: findSomeoneMatch,
                builder: (context, state) => const FindSomeoneResultScreen(),
              ),
            ],
          ),
          // Chat opens the conversation directly; the nested id route lets a
          // future match or connection push its own thread onto the same
          // screen without a second navigation system.
          GoRoute(
            path: chatPath,
            name: chat,
            builder: (context, state) => const ChatScreen(),
            routes: [
              GoRoute(
                path: ':conversationId',
                name: chatConversation,
                builder: (context, state) => ChatScreen(
                  conversationId:
                      state.pathParameters['conversationId'] ??
                      kDefaultChatConversationId,
                ),
              ),
            ],
          ),
          GoRoute(
            path: meetingsPath,
            name: meetings,
            builder: (context, state) => const MeetingsScreen(),
          ),
          GoRoute(
            path: profilePath,
            name: profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      // Auth flows live outside [AppShell]: they are full-screen and must not
      // show the bottom navigation bar or rail.
      GoRoute(
        path: signUpPath,
        name: signUp,
        pageBuilder: (context, state) =>
            fadeTransition(state, const SignUpScreen()),
      ),
      GoRoute(
        path: loginPath,
        name: login,
        pageBuilder: (context, state) =>
            fadeTransition(state, const LogInScreen()),
      ),
    ],
    refreshListenable: Listenable.merge([authState]),
    redirect: (context, state) {
      return null;

      /// Auth reirection flow
      /*   if (authState.value == null) {
        return null;
      }
      if (authState.value!.unwrapPrevious().hasError) {
        // Return Login Route
        return AppRouter.login;
      }
      if (authState.value!.isLoading || !authState.value!.hasValue) {
        // Return Splash Route
        return AppRouter.splash;
      }

      final isAuth = !(authState.value!.value?.session?.isExpired ?? true);

      final isSplash = state.uri.path == AppRouter.splash;
      if (isSplash) {
        return isAuth ? AppRouter.home : AppRouter.login;
      }

      final isLoggingIn = state.uri.path == AppRouter.login;
      if (isLoggingIn) return isAuth ? AppRouter.home : null;

      return isAuth ? null : AppRouter.splash; */
    },
  );

  CustomTransitionPage<void> fadeTransition(
    GoRouterState state,
    Widget screen,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
            opacity: animation.drive(
              Tween<double>(
                begin: 0,
                end: 1,
              ).chain(CurveTween(curve: Curves.easeIn)),
            ),
            child: child,
          ),
    );
  }

  CustomTransitionPage<void> slideTransition(
    GoRouterState state,
    Widget screen,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeIn)),
            ),
            child: child,
          ),
    );
  }

  static void goNamed(
    String route, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) => _rootNavigatorKey.currentState?.context.goNamed(
    route,
    extra: extra,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
  );

  static void go(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) => _rootNavigatorKey.currentState?.context.goNamed(
    name,
    extra: extra,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
  );

  /// Navigate to a named route onto the page stack.
  static Future<T?>? pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) => _rootNavigatorKey.currentState?.context.pushNamed<T>(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  static void pop<T extends Object?>([T? result]) =>
      _rootNavigatorKey.currentContext?.pop(result);

  static T read<T>(ProviderBase<T> provider) {
    return ProviderScope.containerOf(rootContext, listen: false).read(provider);
  }

  static T watch<T>(ProviderBase<T> provider) {
    return ProviderScope.containerOf(rootContext).read(provider);
  }
}
