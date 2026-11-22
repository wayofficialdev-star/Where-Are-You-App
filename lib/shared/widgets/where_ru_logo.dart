import 'package:flutter/material.dart';

/// The official Where RU logo.
///
/// Rendered straight from `assets/images/where_ru_logo.png` (declared in
/// `pubspec.yaml` through `assets/images/`), keeping the artwork untouched and
/// its intrinsic proportions intact.
class WhereRuLogo extends StatelessWidget {
  const WhereRuLogo({this.width = 176, super.key});

  /// Logical width; the height follows the artwork's aspect ratio.
  final double width;

  static const String assetPath = 'assets/images/where_ru_logo.png';

  /// Intrinsic ratio of the shipped artwork (1427 × 1102).
  static const double aspectRatio = 1427 / 1102;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Where RU',
      image: true,
      child: Image.asset(
        assetPath,
        width: width,
        height: width / aspectRatio,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
      ),
    );
  }
}
