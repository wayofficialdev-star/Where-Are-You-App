// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get findSomeone => 'FIND SOMEONE';

  @override
  String get findSomeoneSubtitle =>
      'Search for people around you and start your next meeting.';

  @override
  String get findSomeoneTitle => 'Find Someone';

  @override
  String get meetingHistory => 'Meeting history';

  @override
  String get seeAll => 'See all';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String xpValue(int xp) {
    return '$xp XP';
  }

  @override
  String coinsValue(int coins) {
    return '$coins Coins';
  }

  @override
  String xpToNextLevel(int xp) {
    return '$xp XP to next level';
  }

  @override
  String homeGreeting(String name) {
    return 'Hi, $name!';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsEmpty => 'No new notifications yet.';

  @override
  String get meetings => 'Meetings';

  @override
  String get profile => 'Profile';

  @override
  String get retry => 'Retry';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get searchPeopleHint => 'Search by name or interest';

  @override
  String get noPeopleNearby => 'No one nearby yet. Try a different search.';

  @override
  String kmAway(double distance) {
    return '$distance km away';
  }

  @override
  String get noMeetingsYet => 'Your meetings will show up here.';

  @override
  String get backendNotConnected =>
      'This action will be available once the backend is connected.';
}
