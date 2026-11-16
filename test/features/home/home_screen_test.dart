import 'package:app/features/home/home.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('renders the Where RU dashboard', (tester) async {
      tester.view.physicalSize = const Size(430, 1400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Where RU'), findsOneWidget);
      expect(find.text('FIND SOMEONE'), findsOneWidget);
      expect(find.textContaining('Level 4'), findsOneWidget);
      expect(find.text('Anagha'), findsOneWidget);
      expect(find.text('Marine Drive, Kochi'), findsOneWidget);
    });
  });
}
