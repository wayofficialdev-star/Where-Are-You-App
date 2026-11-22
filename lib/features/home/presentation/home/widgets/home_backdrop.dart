import 'dart:ui' show ImageFilter;

import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Pastel gradient with blurred blobs behind the home dashboard.
///
/// The blobs use fractional [Alignment] values and are clipped, so they bleed
/// off the edges without ever reporting a layout overflow.
class HomeBackdrop extends StatelessWidget {
  const HomeBackdrop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F6FF), Color(0xFFF3F7FE), Color(0xFFFBF3FB)],
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            const Align(
              alignment: Alignment(1.25, -1.35),
              child: _Blob(size: 340, color: Color(0xFFEDE3FF)),
            ),
            const Align(
              alignment: Alignment(-1.45, -0.15),
              child: _Blob(size: 300, color: Color(0xFFE3ECFF)),
            ),
            const Align(
              alignment: Alignment(-1.25, 1.3),
              child: _Blob(size: 360, color: Color(0xFFF9DEF1)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

/// White rounded panel that holds the dashboard content.
class HomeSurface extends StatelessWidget {
  const HomeSurface({
    required this.child,
    this.radius = 28,
    this.padding = const EdgeInsets.all(16),
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
            offset: const Offset(0, 16),
            blurRadius: 40,
            color: WhereRuBrand.navy.withValues(alpha: .07),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
