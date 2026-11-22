import 'package:app/features/auth/auth.dart';
import 'package:flutter/material.dart';

/// Phone layout: the card sits edge to edge and the content scrolls.
class SignUpScreenMobile extends StatelessWidget {
  const SignUpScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: AuthBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(14, 6, 14, 20),
            child: SignUpCard(
              radius: 26,
              padding: EdgeInsets.fromLTRB(18, 8, 18, 22),
              child: SignUpBody(isCompact: true),
            ),
          ),
        ),
      ),
    );
  }
}
