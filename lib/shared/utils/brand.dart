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

  static const Color pastelPeach = Color(0xFFFFF0E4);
  static const Color pastelMint = Color(0xFFE6F8F0);
  static const Color pastelLavender = Color(0xFFF2EEFF);

  static const List<Color> pastels = [
    pastelBlue,
    pastelPurple,
    pastelPink,
    pastelMint,
    pastelPeach,
  ];

  /// Hairline used for card borders and in-card dividers.
  static const Color hairline = Color(0xFFEDEFF5);

  /// Rating stars, notification badges and the redeem highlight.
  static const Color star = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFF04438);
  static const Color reward = Color(0xFFE84393);

  static const Color coral = Color(0xFFFF8A5C);
  static const Color facebook = Color(0xFF1877F2);

  /// Auth surfaces: near-white field fill, hairline border, muted icon/hint.
  static const Color fieldFill = Color(0xFFF9FAFD);
  static const Color fieldBorder = Color(0xFFE3E6EF);
  static const Color fieldIcon = Color(0xFF565C6B);
  static const Color hint = Color(0xFF6E7488);
  static const Color body = Color(0xFF5B6280);

  /// Violet → pink → coral, used for the highlighted heading word.
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFFF4FA3), coral],
  );

  /// Indigo → violet, used for the selected time filter pill.
  static const LinearGradient selectedPillGradient = LinearGradient(
    colors: [Color(0xFF4A63F0), Color(0xFF8B4FF0)],
  );

  /// Call-to-action gradient: azure → violet → magenta → coral.
  static const LinearGradient ctaGradient = LinearGradient(
    colors: [Color(0xFF3FA2FF), Color(0xFF6B5BFF), Color(0xFFE93FC1), coral],
  );

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
