import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Google / Apple / Facebook entry points.
///
/// The providers are visual placeholders until authentication is connected, so
/// every tile calls [onUnavailable] instead of starting an OAuth flow.
class SocialLogins extends StatelessWidget {
  const SocialLogins({
    required this.onUnavailable,
    this.isCompact = true,
    super.key,
  });

  final VoidCallback onUnavailable;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final gap = isCompact ? 14.0 : 20.0;
    final radius = isCompact ? 20.0 : 24.0;
    final googleSize = isCompact ? 32.0 : 42.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isCompact ? 320 : 372),
        child: Row(
          children: [
            Expanded(
              child: _SocialTile(
                label: context.l10n.continueWithGoogle,
                onTap: onUnavailable,
                radius: radius,
                child: _GoogleMark(size: googleSize),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: _SocialTile(
                label: context.l10n.continueWithApple,
                onTap: onUnavailable,
                radius: radius,
                child: Icon(
                  Icons.apple,
                  size: googleSize * 1.06,
                  color: const Color(0xFF0B0B0F),
                ),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: _SocialTile(
                label: context.l10n.continueWithFacebook,
                onTap: onUnavailable,
                radius: radius,
                child: Icon(
                  Icons.facebook,
                  size: googleSize * 1.12,
                  color: WhereRuBrand.facebook,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialTile extends StatelessWidget {
  const _SocialTile({
    required this.label,
    required this.onTap,
    required this.radius,
    required this.child,
  });

  final String label;
  final VoidCallback onTap;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: AspectRatio(
          aspectRatio: 1.06,
          child: Material(
            color: const Color(0xFFF4F5FB),
            borderRadius: borderRadius,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

/// Minimal Google "G" mark drawn with arcs, so no icon package is needed.
class _GoogleMark extends StatelessWidget {
  const _GoogleMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: const _GoogleMarkPainter(),
    );
  }
}

class _GoogleMarkPainter extends CustomPainter {
  const _GoogleMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const red = Color(0xFFEA4335);
    const yellow = Color(0xFFFBBC05);
    const green = Color(0xFF34A853);
    const blue = Color(0xFF4285F4);

    final stroke = size.width * .2;
    final radius = (size.width - stroke) / 2;
    final center = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: center, radius: radius);

    void arc(Color color, double start, double sweep) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke;
      canvas.drawArc(rect, start, sweep, false, paint);
    }

    arc(blue, -.65, 1.55);
    arc(green, .9, 1.45);
    arc(yellow, 2.35, 1.45);
    arc(red, 3.8, 1.8);

    canvas.drawRect(
      Rect.fromLTWH(
        center.dx,
        center.dy - stroke / 2,
        radius + stroke / 2,
        stroke,
      ),
      Paint()..color = blue,
    );
  }

  @override
  bool shouldRepaint(_GoogleMarkPainter oldDelegate) => false;
}
