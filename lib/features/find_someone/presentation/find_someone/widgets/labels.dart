import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Icon and pastel colours for an activity card.
class ActivityVisual {
  const ActivityVisual({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
}

ActivityVisual activityVisual(MatchActivity activity) {
  return switch (activity) {
    MatchActivity.teaCoffee => const ActivityVisual(
      icon: Icons.emoji_food_beverage_rounded,
      background: WhereRuBrand.pastelBlue,
      foreground: WhereRuBrand.blue,
    ),
    MatchActivity.movies => const ActivityVisual(
      icon: Icons.movie_filter_rounded,
      background: WhereRuBrand.pastelPink,
      foreground: Color(0xFFE84393),
    ),
    MatchActivity.dinner => const ActivityVisual(
      icon: Icons.restaurant_rounded,
      background: WhereRuBrand.pastelPeach,
      foreground: Color(0xFFF08A3C),
    ),
    MatchActivity.walks => const ActivityVisual(
      icon: Icons.directions_walk_rounded,
      background: WhereRuBrand.pastelMint,
      foreground: Color(0xFF22A06B),
    ),
    MatchActivity.gaming => const ActivityVisual(
      icon: Icons.sports_esports_rounded,
      background: WhereRuBrand.pastelPurple,
      foreground: WhereRuBrand.purple,
    ),
    MatchActivity.shopping => const ActivityVisual(
      icon: Icons.shopping_bag_rounded,
      background: WhereRuBrand.pastelPink,
      foreground: Color(0xFFD6357A),
    ),
  };
}

String activityLabel(AppLocalizations l10n, MatchActivity activity) {
  return switch (activity) {
    MatchActivity.teaCoffee => l10n.activityTeaCoffee,
    MatchActivity.movies => l10n.activityMovies,
    MatchActivity.dinner => l10n.activityDinner,
    MatchActivity.walks => l10n.activityWalks,
    MatchActivity.gaming => l10n.activityGaming,
    MatchActivity.shopping => l10n.activityShopping,
  };
}

IconData interestIcon(MatchInterest interest) {
  return switch (interest) {
    MatchInterest.tech => Icons.computer_rounded,
    MatchInterest.business => Icons.business_center_rounded,
    MatchInterest.sports => Icons.sports_basketball_rounded,
    MatchInterest.travel => Icons.flight_takeoff_rounded,
    MatchInterest.music => Icons.music_note_rounded,
    MatchInterest.food => Icons.restaurant_rounded,
    MatchInterest.movies => Icons.movie_rounded,
    MatchInterest.gaming => Icons.sports_esports_rounded,
    MatchInterest.books => Icons.menu_book_rounded,
    MatchInterest.art => Icons.palette_rounded,
    MatchInterest.other => Icons.more_horiz_rounded,
  };
}

String interestLabel(AppLocalizations l10n, MatchInterest interest) {
  return switch (interest) {
    MatchInterest.tech => l10n.interestTech,
    MatchInterest.business => l10n.interestBusiness,
    MatchInterest.sports => l10n.interestSports,
    MatchInterest.travel => l10n.interestTravel,
    MatchInterest.music => l10n.interestMusic,
    MatchInterest.food => l10n.interestFood,
    MatchInterest.movies => l10n.interestMovies,
    MatchInterest.gaming => l10n.interestGaming,
    MatchInterest.books => l10n.interestBooks,
    MatchInterest.art => l10n.interestArt,
    MatchInterest.other => l10n.interestOther,
  };
}

String meetingTimeLabel(AppLocalizations l10n, MeetingTimeOption option) {
  return switch (option) {
    MeetingTimeOption.now => l10n.timeNow,
    MeetingTimeOption.today => l10n.timeToday,
    MeetingTimeOption.thisWeek => l10n.timeThisWeek,
    MeetingTimeOption.anytime => l10n.timeAnytime,
  };
}

IconData meetingTimeIcon(MeetingTimeOption option) {
  return switch (option) {
    MeetingTimeOption.now => Icons.bolt_rounded,
    MeetingTimeOption.today => Icons.today_rounded,
    MeetingTimeOption.thisWeek => Icons.date_range_rounded,
    MeetingTimeOption.anytime => Icons.all_inclusive_rounded,
  };
}
