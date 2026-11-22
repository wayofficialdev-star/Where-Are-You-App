import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

/// Pale gradient with blurred pastel circles behind the auth surfaces.
///
/// The blobs are aligned with fractional [Alignment] values and clipped, so
/// they bleed off the edges without ever reporting a layout overflow.
class AuthBackground extends StatelessWidget {
  const AuthBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFDFEFF), Color(0xFFF3F7FE), Color(0xFFFCEFF6)],
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            const Align(
              alignment: Alignment(1.15, -1.3),
              child: _Blob(size: 430, color: Color(0xFFF0E4FF), opacity: .95),
            ),
            const Align(
              alignment: Alignment(-1.5, 0.02),
              child: _Blob(size: 380, color: Color(0xFFDDE9FF), opacity: .8),
            ),
            const Align(
              alignment: Alignment(-1.2, 1.25),
              child: _Blob(size: 420, color: Color(0xFFFBDCEE), opacity: .85),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color, required this.opacity});

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: opacity),
        ),
      ),
    );
  }
}
