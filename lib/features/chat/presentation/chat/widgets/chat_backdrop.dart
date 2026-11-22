import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

/// Pastel gradient with blurred blobs behind the chat surface.
///
/// Mirrors the decorative treatment used by the home and matchmaking screens,
/// clipped so the blobs never cause a layout overflow.
class ChatBackdrop extends StatelessWidget {
  const ChatBackdrop({required this.child, super.key});

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
              alignment: Alignment(1.3, -1.25),
              child: _Blob(size: 320, color: Color(0xFFE9DDFF)),
            ),
            const Align(
              alignment: Alignment(-1.55, 0.05),
              child: _Blob(size: 280, color: Color(0xFFE0EBFF)),
            ),
            const Align(
              alignment: Alignment(-1.2, 1.3),
              child: _Blob(size: 340, color: Color(0xFFFADFF1)),
            ),
            child,
          ],
        ),
      ),
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
      imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
