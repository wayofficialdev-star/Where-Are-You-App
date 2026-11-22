import 'package:app/features/chat/domain/chat_domain.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';

String chatActivityLabel(AppLocalizations l10n, ChatActivity activity) {
  return switch (activity) {
    ChatActivity.teaCoffee => l10n.activityTeaCoffee,
    ChatActivity.movies => l10n.activityMovies,
    ChatActivity.dinner => l10n.activityDinner,
    ChatActivity.walks => l10n.activityWalks,
    ChatActivity.gaming => l10n.activityGaming,
    ChatActivity.shopping => l10n.activityShopping,
  };
}

IconData chatActivityIcon(ChatActivity activity) {
  return switch (activity) {
    ChatActivity.teaCoffee => Icons.emoji_food_beverage_rounded,
    ChatActivity.movies => Icons.movie_filter_rounded,
    ChatActivity.dinner => Icons.restaurant_rounded,
    ChatActivity.walks => Icons.directions_walk_rounded,
    ChatActivity.gaming => Icons.sports_esports_rounded,
    ChatActivity.shopping => Icons.shopping_bag_rounded,
  };
}

String chatScheduleLabel(AppLocalizations l10n, ChatSchedule schedule) {
  return switch (schedule) {
    ChatSchedule.todayEvening => l10n.chatTodayEvening,
    ChatSchedule.today => l10n.timeToday,
    ChatSchedule.thisWeek => l10n.timeThisWeek,
    ChatSchedule.anytime => l10n.timeAnytime,
  };
}
