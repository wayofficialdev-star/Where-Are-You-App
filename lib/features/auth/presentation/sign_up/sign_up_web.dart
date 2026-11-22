import 'package:app/features/auth/auth.dart';
import 'package:flutter/material.dart';

/// Web / desktop layout: a centered card with a capped content width, so the
/// form never stretches across a wide window.
class SignUpScreenWeb extends StatelessWidget {
  const SignUpScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AuthBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 34),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: const SignUpCard(
                          radius: 34,
                          padding: EdgeInsets.fromLTRB(52, 26, 52, 40),
                          child: SignUpBody(isCompact: false),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
