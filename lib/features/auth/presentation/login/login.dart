import 'package:app/features/auth/auth.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Placeholder destination for the Log In link.
///
/// The log-in design is not part of this task; this screen only keeps the
/// navigation contract honest so the sign-up footer points somewhere real.
class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  void _close(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRouter.homePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AuthBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: SignUpCard(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => _close(context),
                          tooltip: context.l10n.back,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: WhereRuBrand.navy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const WhereRuLogo(width: 108),
                      const SizedBox(height: 24),
                      Text(
                        context.l10n.logInAction,
                        style: AppText.heading4.copyWith(
                          color: WhereRuBrand.navy,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        context.l10n.logInComingSoon,
                        textAlign: TextAlign.center,
                        style: AppText.mediumN.copyWith(
                          color: AppColors.stormyBlue,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
