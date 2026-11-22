import 'package:app/features/auth/auth.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart' show SnackBarX;

/// Content shared by the mobile and web sign-up layouts.
///
/// Layout only: form state lives in the sign-up notifier and submissions go
/// through [IAuthRepository], so no business logic sits in this widget.
class SignUpBody extends ConsumerStatefulWidget {
  const SignUpBody({required this.isCompact, super.key});

  /// Mobile spacing and type scale.
  final bool isCompact;

  @override
  ConsumerState<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends ConsumerState<SignUpBody> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _location = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    _location.dispose();
    super.dispose();
  }

  void _close() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRouter.homePath);
    }
  }

  void _notConnected() {
    context.showSnackBar(context.l10n.backendNotConnected);
  }

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fullNameRequired;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return context.l10n.emailRequired;
    final pattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return pattern.hasMatch(email) ? null : context.l10n.emailInvalid;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return context.l10n.passwordRequired;
    if (password.length < 8) return context.l10n.passwordTooShort;
    return null;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final result = await ref
        .read(signUpNotifierProvider.notifier)
        .submit(
          SignUpRequest(
            fullName: _fullName.text.trim(),
            email: _email.text.trim(),
            password: _password.text,
            location: _location.text.trim(),
          ),
        );

    if (!mounted) return;
    switch (result) {
      case SignUpResult.backendUnavailable:
        _notConnected();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpNotifierProvider);
    final l10n = context.l10n;
    final compact = widget.isCompact;

    final titleStyle = TextStyle(
      fontSize: compact ? 30 : 46,
      fontWeight: FontWeight.w800,
      height: compact ? 1.16 : 1.12,
      letterSpacing: compact ? -.8 : -1.5,
      color: WhereRuBrand.navy,
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: _close,
              tooltip: l10n.back,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: compact ? 19 : 21,
                color: WhereRuBrand.navy,
              ),
            ),
          ),
          SizedBox(height: compact ? 2 : 6),
          Center(child: WhereRuLogo(width: compact ? 120 : 176)),
          SizedBox(height: compact ? 22 : 30),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: compact ? 8 : 12,
            runSpacing: 2,
            children: [
              Text(l10n.signUpTitleLead, style: titleStyle),
              GradientText(l10n.signUpTitleAccent, style: titleStyle),
            ],
          ),
          SizedBox(height: compact ? 10 : 14),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: compact ? 330 : 380),
              child: Text(
                l10n.signUpSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: compact ? 14.5 : 18.5,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: .1,
                  color: WhereRuBrand.body,
                ),
              ),
            ),
          ),
          SizedBox(height: compact ? 24 : 44),
          AuthTextField(
            controller: _fullName,
            hint: l10n.fullNameLabel,
            icon: Icons.person_outline_rounded,
            isCompact: compact,
            verticalPadding: compact ? 16.5 : 20,
            radius: compact ? 15 : 16,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            validator: _validateFullName,
          ),
          SizedBox(height: compact ? 12 : 15),
          AuthTextField(
            controller: _email,
            hint: l10n.emailLabel,
            icon: Icons.mail_outline_rounded,
            isCompact: compact,
            verticalPadding: compact ? 16.5 : 20,
            radius: compact ? 15 : 16,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            validator: _validateEmail,
          ),
          SizedBox(height: compact ? 12 : 15),
          AuthTextField(
            controller: _password,
            hint: l10n.passwordLabel,
            icon: Icons.lock_outline_rounded,
            isCompact: compact,
            verticalPadding: compact ? 16.5 : 20,
            radius: compact ? 15 : 16,
            obscureText: state.isPasswordObscured,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            validator: _validatePassword,
            suffixIcon: IconButton(
              onPressed: () => ref
                  .read(signUpNotifierProvider.notifier)
                  .togglePasswordVisibility(),
              tooltip: state.isPasswordObscured
                  ? l10n.showPassword
                  : l10n.hidePassword,
              icon: Icon(
                state.isPasswordObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 21,
                color: WhereRuBrand.fieldIcon,
              ),
            ),
          ),
          SizedBox(height: compact ? 12 : 15),
          AuthTextField(
            controller: _location,
            hint: l10n.locationLabel,
            icon: Icons.location_on_outlined,
            isCompact: compact,
            verticalPadding: compact ? 16.5 : 20,
            radius: compact ? 15 : 16,
            readOnly: true,
            onTap: _notConnected,
          ),
          SizedBox(height: compact ? 22 : 28),
          GradientButton(
            label: l10n.signUpAction,
            isLoading: state.isSubmitting,
            height: compact ? 54 : 60,
            fontSize: compact ? 17 : 19.5,
            onPressed: state.isSubmitting ? null : _submit,
          ),
          SizedBox(height: compact ? 26 : 40),
          _OrDivider(label: l10n.orContinueWith, isCompact: compact),
          SizedBox(height: compact ? 24 : 40),
          SocialLogins(isCompact: compact, onUnavailable: _notConnected),
          SizedBox(height: compact ? 26 : 32),
          _LogInPrompt(
            isCompact: compact,
            onLogIn: () => context.go(AppRouter.loginPath),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.label, required this.isCompact});

  final String label;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(height: 1, color: WhereRuBrand.fieldBorder),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            label,
            style: TextStyle(
              fontSize: isCompact ? 13 : 14.5,
              fontWeight: FontWeight.w400,
              color: WhereRuBrand.hint,
            ),
          ),
        ),
        const Expanded(
          child: Divider(height: 1, color: WhereRuBrand.fieldBorder),
        ),
      ],
    );
  }
}

class _LogInPrompt extends StatelessWidget {
  const _LogInPrompt({required this.onLogIn, required this.isCompact});

  final VoidCallback onLogIn;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final fontSize = isCompact ? 14.0 : 15.5;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          context.l10n.alreadyHaveAccount,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            color: WhereRuBrand.body,
          ),
        ),
        InkWell(
          onTap: onLogIn,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Text(
              context.l10n.logInAction,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: WhereRuBrand.purple,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
