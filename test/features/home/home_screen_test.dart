import 'package:app/features/home/home.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Widget _app() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeScreen(),
    ),
  );
}

/// Home wired to the real matchmaking route, so its entry points can be
/// exercised without booting Supabase.
Widget _routedApp() {
  return ProviderScope(
    child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: AppRouter.homePath,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRouter.findSomeonePath,
            builder: (context, state) =>
                const Scaffold(body: Text('Find someone stub')),
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
  group('HomeScreen', () {
    testWidgets('renders the dashboard content', (tester) async {
      _setSize(tester, const Size(390, 900));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.textContaining('Good morning'), findsOneWidget);
      expect(find.text('Ready to make a plan?'), findsOneWidget);
      expect(find.text('Find a Match'), findsOneWidget);
      expect(find.text('Right now'), findsOneWidget);
      expect(find.text('120'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);
      expect(find.text('What are you up for?'), findsOneWidget);
      expect(find.text('Tea / Coffee'), findsOneWidget);
      expect(find.text('Recent meetups'), findsOneWidget);
      expect(find.text('Sneha Nair'), findsOneWidget);
      expect(find.text('Arjun Menon'), findsOneWidget);
      expect(
        find.text('Approximate distance only · Meet in public places'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('selecting a time filter keeps the layout stable', (
      tester,
    ) async {
      _setSize(tester, const Size(390, 900));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Within 1 hour'));
      await tester.pumpAndSettle();

      expect(find.text('Within 1 hour'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the match card opens the matchmaking flow', (tester) async {
      _setSize(tester, const Size(390, 900));

      await tester.pumpWidget(_routedApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Find a Match'));
      await tester.pumpAndSettle();

      expect(find.text('Find someone stub'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('an activity tile opens the matchmaking flow', (tester) async {
      _setSize(tester, const Size(390, 900));

      await tester.pumpWidget(_routedApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tea / Coffee'));
      await tester.pumpAndSettle();

      expect(find.text('Find someone stub'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 320x720', (tester) async {
      _setSize(tester, const Size(320, 720));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Find a Match'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 390x844', (tester) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Recent meetups'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 1440x900 and the content stays capped', (
      tester,
    ) async {
      _setSize(tester, const Size(1440, 900));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      final surface = tester.getSize(find.byType(HomeSurface));
      expect(surface.width, lessThanOrEqualTo(720));
      expect(tester.takeException(), isNull);
    });
  });
}
