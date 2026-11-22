import 'package:app/features/chat/chat.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

const _chatPath = '/chat';

/// Mirrors the production routes so navigation can be exercised without
/// booting Supabase.
GoRouter _router({String initialLocation = _chatPath}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: _chatPath,
        builder: (context, state) => const ChatScreen(),
        routes: [
          GoRoute(
            path: ':conversationId',
            builder: (context, state) => ChatScreen(
              conversationId:
                  state.pathParameters['conversationId'] ??
                  kDefaultChatConversationId,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRouter.findSomeonePath,
        builder: (context, state) =>
            const Scaffold(body: Text('Find someone stub')),
      ),
    ],
  );
}

Widget _app({String initialLocation = _chatPath}) {
  return ProviderScope(
    child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router(initialLocation: initialLocation),
    ),
  );
}

Widget _shellApp() {
  return ProviderScope(
    child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: _chatPath,
        routes: [
          ShellRoute(
            builder: (context, state, child) =>
                AppShell(location: state.uri.path, child: child),
            routes: [
              GoRoute(
                path: AppRouter.homePath,
                builder: (context, state) =>
                    const Scaffold(body: Text('Home tab')),
              ),
              GoRoute(
                path: AppRouter.findSomeonePath,
                builder: (context, state) =>
                    const Scaffold(body: Text('Matches tab')),
              ),
              GoRoute(
                path: _chatPath,
                builder: (context, state) => const ChatScreen(),
              ),
              GoRoute(
                path: AppRouter.profilePath,
                builder: (context, state) =>
                    const Scaffold(body: Text('Profile tab')),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  group('ChatScreen', () {
    testWidgets('renders the chat surface and participant information', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('chat-surface')), findsOneWidget);
      expect(find.text('Anagha'), findsOneWidget);
      expect(find.text('Online now'), findsOneWidget);
      expect(find.text('22 • Kochi'), findsOneWidget);
      expect(find.text('Tea / Coffee'), findsOneWidget);
      expect(find.text('Today, Evening'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders the match information banner', (tester) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('You matched for Tea / Coffee'), findsOneWidget);
      expect(find.text('Feel free to chat and plan together!'), findsOneWidget);
      expect(find.text('View Match Details'), findsOneWidget);
      expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders incoming and outgoing messages with timestamps', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Hi Krishnan! 👋'), findsOneWidget);
      expect(find.text('Hi! 😊\nNice to meet you here!'), findsOneWidget);
      expect(
        find.text('Same here! Are you still up\nfor tea today?'),
        findsOneWidget,
      );
      expect(find.text('4:12 PM'), findsOneWidget);
      expect(find.text('4:13 PM'), findsOneWidget);

      // The rest of the conversation sits below the fold; scroll to it.
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      expect(find.text('Yes! Which place do you prefer?'), findsOneWidget);
      expect(
        find.text("How about Lulu Mall?\nThere's a nice cafe there."),
        findsOneWidget,
      );
      expect(find.text('Sounds good! See you there 😊'), findsOneWidget);
      expect(find.text('4:17 PM'), findsOneWidget);
      // Outgoing messages carry the read double-check.
      expect(find.byIcon(Icons.done_all_rounded), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders the composer and reports the backend boundary', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Type a message...'), findsOneWidget);
      expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
      expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
      expect(find.byIcon(Icons.add_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.mic_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(
        find.text('Messaging will be available once the backend is connected.'),
        findsOneWidget,
      );
    });

    testWidgets('opens through the chat route and navigates back', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.byType(ChatScreen), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Find someone stub'), findsOneWidget);
    });

    testWidgets('opens a specific conversation through its route', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app(initialLocation: '/chat/match-anagha'));
      await tester.pumpAndSettle();

      expect(find.text('Anagha'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('keeps the Chat tab selected in the shell', (tester) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_shellApp());
      await tester.pumpAndSettle();

      expect(find.text('Anagha'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_rounded), findsOneWidget);

      await tester.tap(find.text('Matches'));
      await tester.pumpAndSettle();
      expect(find.text('Matches tab'), findsOneWidget);

      await tester.tap(find.text('Chat'));
      await tester.pumpAndSettle();
      expect(find.text('Anagha'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_rounded), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('responsive layout', () {
    for (final size in const [
      Size(320, 720),
      Size(390, 844),
      Size(1440, 900),
    ]) {
      testWidgets('renders without overflow at $size', (tester) async {
        _setSize(tester, size);

        await tester.pumpWidget(_app());
        await tester.pumpAndSettle();

        expect(find.text('Anagha'), findsOneWidget);
        expect(find.text('Type a message...'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('centres the chat surface on desktop', (tester) async {
      _setSize(tester, const Size(1440, 900));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      final card = tester.getSize(find.byType(ConversationSummaryCard));
      expect(card.width, lessThanOrEqualTo(680));
      expect(tester.takeException(), isNull);
    });
  });
}
