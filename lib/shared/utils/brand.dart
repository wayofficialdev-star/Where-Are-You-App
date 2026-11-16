import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Where RU brand accents.
///
/// Base colours, typography and components still come from the Hancod theme
/// ([AppColors], [AppText], [AppStyles]); this file only adds the blue → purple
/// → pink gradient and the pastel surfaces that are specific to Where RU.
abstract final class WhereRuBrand {
  static const Color navy = Color(0xFF1D1B3A);
  static const Color blue = Color(0xFF3D7BFF);
  static const Color purple = AppColors.brandViolet;
  static const Color pink = Color(0xFFFF5C8A);

  static const Color background = Color(0xFFF7F8FC);
  static const Color pastelBlue = Color(0xFFEAF1FF);
  static const Color pastelPurple = Color(0xFFF0EBFF);
  static const Color pastelPink = Color(0xFFFFEDF3);

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, purple, pink],
  );

  static const List<Color> pastels = [pastelBlue, pastelPurple, pastelPink];

  /// Soft, rounded surface used by the Where RU cards.
  static BoxDecoration cardDecoration({
    Color color = AppColors.white,
    double radius = 20,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 10),
          blurRadius: 24,
          color: navy.withValues(alpha: .06),
        ),
      ],
    );
  }

  /// Deterministic pastel for avatars and list decorations.
  static Color pastelFor(String seed) {
    if (seed.isEmpty) return pastelBlue;
    return pastels[seed.codeUnits.first % pastels.length];
  }

  /// Initials used by the avatar placeholders.
  static String initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
