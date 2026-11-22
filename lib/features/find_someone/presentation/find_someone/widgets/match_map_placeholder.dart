import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Stylised map stand-in for the match result.
///
/// Deliberately a painted placeholder: there is no map SDK or location API in
/// the project yet, and no real coordinates are ever exposed. Only an
/// approximate distance is shown, matching the safety rules on Home.
// TODO(where-ru): swap for the real map once the location provider is chosen.
class MatchMapPlaceholder extends StatelessWidget {
  const MatchMapPlaceholder({
    required this.distanceKm,
    required this.initials,
    this.height = 210,
    super.key,
  });

  final double distanceKm;
  final String initials;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            const Positioned.fill(child: CustomPaint(painter: _MapPainter())),
            Positioned(
              left: 26,
              top: height * .18,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: WhereRuBrand.pastelPurple,
                  border: Border.all(color: AppColors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 8),
                      blurRadius: 18,
                      color: WhereRuBrand.navy.withValues(alpha: .18),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: WhereRuBrand.purple,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: height * .16,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: WhereRuBrand.pink,
                  border: Border.all(color: AppColors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 6),
                      blurRadius: 14,
                      color: WhereRuBrand.pink.withValues(alpha: .35),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.home_rounded,
                  size: 18,
                  color: AppColors.white,
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 6),
                      blurRadius: 16,
                      color: WhereRuBrand.navy.withValues(alpha: .14),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.directions_car_rounded,
                      size: 14,
                      color: WhereRuBrand.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      context.l10n.approxDistance(distanceKm),
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: WhereRuBrand.navy,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                      color: WhereRuBrand.navy.withValues(alpha: .12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  size: 16,
                  color: WhereRuBrand.navy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pale blocks and roads so the area reads as a map without any map data.
class _MapPainter extends CustomPainter {
  const _MapPainter();

  static const _blocks = <(double, double, double, double)>[
    (.03, .06, .22, .2),
    (.28, .04, .16, .14),
    (.5, .08, .2, .16),
    (.76, .04, .2, .22),
    (.04, .34, .16, .18),
    (.24, .3, .14, .14),
    (.62, .32, .16, .16),
    (.82, .36, .16, .2),
    (.06, .6, .2, .18),
    (.3, .62, .16, .16),
    (.52, .58, .14, .2),
    (.72, .64, .22, .18),
    (.04, .84, .26, .14),
    (.36, .86, .2, .12),
    (.6, .86, .3, .12),
  ];

  static const _colors = [
    Color(0xFFE6F2E7),
    Color(0xFFE8EEFB),
    Color(0xFFF6EFE7),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFEEF2F9);
    canvas.drawRect(Offset.zero & size, background);

    final blockPaint = Paint();
    for (var i = 0; i < _blocks.length; i++) {
      final block = _blocks[i];
      blockPaint.color = _colors[i % _colors.length];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * block.$1,
            size.height * block.$2,
            size.width * block.$3,
            size.height * block.$4,
          ),
          const Radius.circular(4),
        ),
        blockPaint,
      );
    }

    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(
        Offset(0, size.height * .5),
        Offset(size.width, size.height * .5),
        road,
      )
      ..drawLine(
        Offset(size.width * .52, 0),
        Offset(size.width * .48, size.height),
        road,
      );

    final route = Path()
      ..moveTo(size.width * .17, size.height * .3)
      ..quadraticBezierTo(
        size.width * .48,
        size.height * .58,
        size.width * .79,
        size.height * .76,
      );

    final routePaint = Paint()
      ..color = WhereRuBrand.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    for (final metric in route.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 7), routePaint);
        distance += 12;
      }
    }
  }

  @override
  bool shouldRepaint(_MapPainter oldDelegate) => false;
}
