import 'package:app/features/auth/auth.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SignUpScreen(),
    ),
  );
}

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  group('SignUpScreen', () {
    testWidgets('renders the design on a mobile-sized layout', (tester) async {
      _setSize(tester, const Size(390, 844));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Create Your'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Your Location (Optional)'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Or continue with'), findsOneWidget);
      expect(find.text('Already have an account?'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);

      final logo = tester.widget<Image>(find.byType(Image));
      expect(logo.image, isA<AssetImage>());
      expect((logo.image as AssetImage).assetName, WhereRuLogo.assetPath);

      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without overflow at a narrow phone width', (
      tester,
    ) async {
      _setSize(tester, const Size(320, 720));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Create Your'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('caps content width on a desktop-sized layout', (tester) async {
      _setSize(tester, const Size(1440, 900));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('Create Your'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);

      final card = tester.getSize(find.byType(SignUpCard));
      expect(card.width, lessThanOrEqualTo(720));
      expect(tester.takeException(), isNull);
    });

    testWidgets('validates required values before submitting', (tester) async {
      _setSize(tester, const Size(390, 1200));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Sign Up'));
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Enter your full name'), findsOneWidget);
      expect(find.text('Enter your email address'), findsOneWidget);
      expect(find.text('Enter a password'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (tester) async {
      _setSize(tester, const Size(390, 1200));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('reports that the backend is not connected', (tester) async {
      _setSize(tester, const Size(390, 1200));

      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'Aarav Nair');
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'aarav@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(2), 'password123');

      await tester.ensureVisible(find.text('Sign Up'));
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'This action will be available once the backend is connected.',
        ),
        findsOneWidget,
      );
    });
  });
}
