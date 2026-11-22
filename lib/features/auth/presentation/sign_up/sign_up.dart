import 'package:app/features/auth/presentation/sign_up/sign_up_mobile.dart';
import 'package:app/features/auth/presentation/sign_up/sign_up_web.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

export 'sign_up_mobile.dart';
export 'sign_up_web.dart';
export 'widgets/widgets.dart';

/// Where RU account creation screen.
///
/// Both layouts render the shared sign-up body; only the surrounding surface
/// differs.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      smallScreen: SignUpScreenMobile(),
      largeScreen: SignUpScreenWeb(),
    );
  }
}
