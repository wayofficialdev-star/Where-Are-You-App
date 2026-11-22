import 'package:app/features/chat/chat.dart';
import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

const _activityPath = '/find-someone';

/// Mirrors the production child routes so navigation can be exercised without
/// booting Supabase.
GoRouter _router() {
  return GoRouter(
    initialLocation: _activityPath,
    routes: [
      GoRoute(
        path: _activityPath,
        name: AppRouter.findSomeone,
        builder: (context, state) => const FindSomeoneScreen(),
        routes: [
          GoRoute(
            path: 'preferences',
            name: AppRouter.findSomeonePreferences,
            builder: (context, state) => const FindSomeonePreferencesScreen(),
          ),
          GoRoute(
            path: 'finding',
            name: AppRouter.findSomeoneFinding,
            builder: (context, state) => const FindSomeoneMatchingScreen(),
          ),
          GoRoute(
            path: 'match',
            name: AppRouter.findSomeoneMatch,
            builder: (context, state) => const FindSomeoneResultScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRouter.profilePath,
        builder: (context, state) => const Scaffold(body: SizedBox()),
      ),
      GoRoute(
        path: AppRouter.chatPath,
        name: AppRouter.chat,
        builder: (context, state) => const ChatScreen(),
        routes: [
          GoRoute(
            path: ':conversationId',
            name: AppRouter.chatConversation,
            builder: (context, state) => ChatScreen(
              conversationId:
                  state.pathParameters['conversationId'] ??
                  kDefaultChatConversationId,
            ),
          ),
        ],
      ),
    ],
  );
}

ProviderContainer _createContainer() {
  final container = ProviderContainer(
    overrides: [matchingStepDelayProvider.overrideWithValue(Duration.zero)],
  );
  addTearDown(container.dispose);
  return container;
}

Widget _app(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router(),
    ),
  );
}

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

/// Selects an activity and at least one interest, then walks to Preferences.
Future<void> _reachPreferences(
  WidgetTester tester,
  ProviderContainer container,
) async {
  await tester.tap(find.text('Tea / Coffee'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Tech'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Next'));
  await tester.pumpAndSettle();
}

/// Runs the simulated scan and waits for the result screen.
Future<void> _reachResult(
  WidgetTester tester,
  ProviderContainer container,
) async {
  await _reachPreferences(tester, container);
  await tester.tap(find.text('Find Someone'));
  await tester.pump();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
}

void main() {
  group('FindSomeoneScreen', () {
    testWidgets('selects an activity and reveals the interest chips', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();

      expect(find.textContaining('Hi Krishnan! 👋'), findsOneWidget);
      expect(find.text('Tea / Coffee'), findsOneWidget);
      expect(find.text('Shopping'), findsOneWidget);
      expect(find.text('Tech'), findsNothing);

      await tester.tap(find.text('Tea / Coffee'));
      await tester.pumpAndSettle();

      expect(
        container.read(findSomeoneNotifierProvider).activity,
        MatchActivity.teaCoffee,
      );
      expect(
        find.text(
          'Great! What are you interested in talking about? '
          'You can select multiple options.',
        ),
        findsOneWidget,
      );
      expect(find.text('Tech'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('allows multiple interests and enables Next', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Movies').first);
      await tester.pumpAndSettle();

      // Next stays disabled until at least one interest is picked.
      var button = tester.widget<GradientButton>(find.byType(GradientButton));
      expect(button.onPressed, isNull);

      await tester.tap(find.text('Tech'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Travel'));
      await tester.tap(find.text('Travel'));
      await tester.pumpAndSettle();

      final state = container.read(findSomeoneNotifierProvider);
      expect(state.interests, {MatchInterest.tech, MatchInterest.travel});

      button = tester.widget<GradientButton>(find.byType(GradientButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('walks to the preferences step', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();

      await _reachPreferences(tester, container);

      expect(
        find.text('How far would you like to meet someone?'),
        findsOneWidget,
      );
      expect(find.text('Up to 10 km'), findsOneWidget);
      expect(
        find.text('Anything else I should know? (Optional)'),
        findsOneWidget,
      );
      expect(find.text('0/100'), findsOneWidget);
      expect(
        container.read(findSomeoneNotifierProvider).step,
        FindSomeoneStep.preferences,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('FindSomeonePreferencesScreen', () {
    testWidgets('changes distance and meeting time', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachPreferences(tester, container);

      final slider = find.byType(Slider);
      final sliderRect = tester.getRect(slider);
      await tester.tapAt(Offset(sliderRect.right - 4, sliderRect.center.dy));
      await tester.pumpAndSettle();

      expect(container.read(findSomeoneNotifierProvider).distanceKm, 50);
      expect(find.text('Up to 50 km'), findsOneWidget);

      await tester.ensureVisible(find.text('Anytime'));
      await tester.tap(find.text('Anytime'));
      await tester.pumpAndSettle();

      expect(
        container.read(findSomeoneNotifierProvider).meetingTime,
        MeetingTimeOption.anytime,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('caps the optional note at 100 characters', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachPreferences(tester, container);

      await tester.enterText(find.byType(TextField), 'x' * 120);
      await tester.pumpAndSettle();

      expect(container.read(findSomeoneNotifierProvider).note.length, 100);
      expect(find.text('100/100'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('FindSomeoneMatchingScreen', () {
    testWidgets('runs the scan and opens the match', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachPreferences(tester, container);

      await tester.tap(find.text('Find Someone'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Finding the right'), findsOneWidget);
      expect(find.text('for you...'), findsOneWidget);
      expect(
        find.text(
          'Our AI is finding someone who also wants to go for Tea / Coffee '
          'and matches your interests.',
        ),
        findsOneWidget,
      );
      expect(find.text('Almost there...'), findsOneWidget);
      expect(find.text('Checking distance (within 10 km)'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(container.read(findSomeoneNotifierProvider).progressStep, 4);
      expect(find.text('We found someone for you!'), findsOneWidget);
    });
  });

  group('FindSomeoneResultScreen', () {
    testWidgets('renders the sample match', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachResult(tester, container);

      expect(find.text('We found someone for you!'), findsOneWidget);
      expect(
        find.text(
          'You both want to go for Tea / Coffee, share similar interests '
          'and are nearby.',
        ),
        findsOneWidget,
      );
      expect(find.text('Anagha'), findsOneWidget);
      expect(find.text('22 • Kochi'), findsOneWidget);
      expect(find.text('~3.2 km away'), findsOneWidget);
      expect(find.text('Tea / Coffee'), findsWidgets);
      expect(find.text('Today, Evening'), findsOneWidget);
      expect(find.text('Common Interests'), findsOneWidget);
      expect(find.text('Connect Now'), findsOneWidget);
      expect(find.text('Try Another Match'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Connect Now opens the match chat and back returns here', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachResult(tester, container);

      await tester.tap(find.text('Connect Now'));
      await tester.pumpAndSettle();

      expect(find.byType(ChatScreen), findsOneWidget);
      expect(find.text('Anagha'), findsOneWidget);
      expect(find.text('Type a message...'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('We found someone for you!'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('View Match Details in the chat reopens the match', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachResult(tester, container);

      await tester.tap(find.text('Connect Now'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('View Match Details'));
      await tester.pumpAndSettle();

      expect(find.byType(FindSomeoneResultScreen), findsOneWidget);
      expect(find.text('Common Interests'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('restarts the scan from Try Another Match', (tester) async {
      _setSize(tester, const Size(390, 844));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();
      await _reachResult(tester, container);

      await tester.tap(find.text('Try Another Match'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Finding the right'), findsOneWidget);
      expect(container.read(findSomeoneNotifierProvider).match, isNull);

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.text('Anagha'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('responsive layout', () {
    for (final size in const [
      Size(320, 720),
      Size(390, 844),
      Size(1440, 900),
    ]) {
      testWidgets('renders every step without overflow at $size', (
        tester,
      ) async {
        _setSize(tester, size);
        final container = _createContainer();

        await tester.pumpWidget(_app(container));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        await _reachPreferences(tester, container);
        expect(tester.takeException(), isNull);

        await tester.tap(find.text('Find Someone'));
        await tester.pump();
        await tester.pump();
        expect(tester.takeException(), isNull);

        await tester.pump(const Duration(milliseconds: 300));
        await tester.pumpAndSettle();
        expect(find.text('Anagha'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('centres the flow instead of stretching it on desktop', (
      tester,
    ) async {
      _setSize(tester, const Size(1440, 900));
      final container = _createContainer();

      await tester.pumpWidget(_app(container));
      await tester.pumpAndSettle();

      final card = tester.getSize(find.byType(ActivityPicker));
      expect(card.width, lessThanOrEqualTo(620));
      expect(tester.takeException(), isNull);
    });
  });
}
