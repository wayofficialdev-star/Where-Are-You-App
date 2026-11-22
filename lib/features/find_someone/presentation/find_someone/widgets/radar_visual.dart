import 'dart:math' as math;

import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Radar-style matching animation: rings, orbiting dots, a central search badge
/// and a few placeholder avatars around it.
class RadarVisual extends StatefulWidget {
  const RadarVisual({this.size = 270, super.key});

  final double size;

  @override
  State<RadarVisual> createState() => _RadarVisualState();
}

class _RadarVisualState extends State<RadarVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 16),
  )..repeat();

  static const _avatars = <(String, double, double)>[
    ('Riya', .18, .2),
    ('Kabir', .8, .14),
    ('Meera', .14, .76),
    ('Arjun', .82, .78),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _ring(double factor, double opacity) {
    final diameter = widget.size * factor;
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: factor == 1
            ? WhereRuBrand.pastelBlue.withValues(alpha: .45)
            : null,
        border: Border.all(
          color: WhereRuBrand.blue.withValues(alpha: opacity),
          width: 1.2,
        ),
      ),
    );
  }

  Widget _dot(double degrees, double factor, Color color, double dotSize) {
    final radians = degrees * math.pi / 180;
    final radius = widget.size / 2 * factor;
    return Positioned(
      left: widget.size / 2 + radius * math.cos(radians) - dotSize / 2,
      top: widget.size / 2 + radius * math.sin(radians) - dotSize / 2,
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = widget.size * .155;
    final centerSize = widget.size * .23;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _ring(1, .18),
          _ring(.78, .22),
          _ring(.56, .26),
          _ring(.34, .3),
          RotationTransition(
            turns: _controller,
            child: Stack(
              children: [
                _dot(-40, .9, WhereRuBrand.pink, 8),
                _dot(35, .72, WhereRuBrand.blue, 6),
                _dot(120, .86, const Color(0xFF34D399), 7),
                _dot(200, .62, WhereRuBrand.purple, 6),
                _dot(265, .78, const Color(0xFFFFC24B), 7),
              ],
            ),
          ),
          Container(
            width: centerSize,
            height: centerSize,
            decoration: BoxDecoration(
              gradient: WhereRuBrand.selectedPillGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 24,
                  color: WhereRuBrand.blue.withValues(alpha: .35),
                ),
              ],
            ),
            child: Icon(
              Icons.search_rounded,
              size: centerSize * .45,
              color: AppColors.white,
            ),
          ),
          for (final avatar in _avatars)
            Positioned(
              left: widget.size * avatar.$2 - avatarSize / 2,
              top: widget.size * avatar.$3 - avatarSize / 2,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: WhereRuBrand.pastelFor(avatar.$1),
                  border: Border.all(color: AppColors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 6),
                      blurRadius: 14,
                      color: WhereRuBrand.navy.withValues(alpha: .12),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    WhereRuBrand.initialsOf(avatar.$1),
                    style: TextStyle(
                      fontSize: avatarSize * .34,
                      fontWeight: FontWeight.w700,
                      color: WhereRuBrand.purple,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
