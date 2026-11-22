import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// White rounded surface that holds the auth forms on every layout.
class SignUpCard extends StatelessWidget {
  const SignUpCard({
    required this.child,
    this.radius = 28,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 18),
            blurRadius: 48,
            color: WhereRuBrand.navy.withValues(alpha: .08),
          ),
        ],
      ),
      child: child,
    );
  }
}
