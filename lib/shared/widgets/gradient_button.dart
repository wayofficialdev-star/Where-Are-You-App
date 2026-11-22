import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Pill-shaped call to action filled with the Where RU gradient.
class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 60,
    this.fontSize = 19.5,
    this.leadingIcon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double fontSize;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final radius = BorderRadius.circular(height / 2);

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: WhereRuBrand.ctaGradient,
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 14),
              blurRadius: 30,
              color: WhereRuBrand.pink.withValues(alpha: .32),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: radius,
          child: InkWell(
            onTap: onPressed,
            borderRadius: radius,
            child: SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: AppColors.white,
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (leadingIcon != null) ...[
                                    Icon(
                                      leadingIcon,
                                      size: fontSize + 1,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                  Flexible(
                                    child: Text(
                                      label,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w600,
                                        height: 1.1,
                                        letterSpacing: .2,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: enabled
                          ? AppColors.white
                          : AppColors.white.withValues(alpha: .7),
                      size: 23,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
