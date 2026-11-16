import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App identity', () {
    testWidgets('renders Where RU localized copy', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Text(context.l10n.findSomeoneTitle),
          ),
        ),
      );

      expect(find.text('Find Someone'), findsOneWidget);
    });

    test('Spanish locale provides the Where RU copy', () async {
      final spanish = await AppLocalizations.delegate.load(const Locale('es'));

      expect(spanish.findSomeoneTitle, 'Encontrar a alguien');
      expect(spanish.meetings, 'Reuniones');
    });
  });
}
