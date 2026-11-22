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

  @override
  String get signUpTitleLead => 'Create Your';

  @override
  String get signUpTitleAccent => 'Account';

  @override
  String get signUpSubtitle =>
      'Join Where R U and start making new friends nearby.';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get locationLabel => 'Your Location (Optional)';

  @override
  String get signUpAction => 'Sign Up';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logInAction => 'Log In';

  @override
  String get back => 'Back';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get fullNameRequired => 'Enter your full name';

  @override
  String get emailRequired => 'Enter your email address';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Enter a password';

  @override
  String get passwordTooShort => 'Use at least 8 characters';

  @override
  String get logInComingSoon =>
      'Log in will be available once authentication is connected.';

  @override
  String goodMorning(String name) {
    return 'Good morning, $name! 👋';
  }

  @override
  String get readyToMakeAPlan => 'Ready to make a plan?';

  @override
  String get matches => 'Matches';

  @override
  String get chat => 'Chat';

  @override
  String get findAMatch => 'Find a Match';

  @override
  String get findAMatchSubtitle =>
      'Find someone nearby who\'s up for the same thing, right now.';

  @override
  String get rightNow => 'Right now';

  @override
  String get withinOneHour => 'Within 1 hour';

  @override
  String get laterToday => 'Later today';

  @override
  String get scheduledTime => 'Scheduled time';

  @override
  String get coins => 'Coins';

  @override
  String get meetups => 'Meetups';

  @override
  String get score => 'Score';

  @override
  String get redeem => 'Redeem';

  @override
  String get whatAreYouUpFor => 'What are you up for?';

  @override
  String get activityTeaCoffee => 'Tea / Coffee';

  @override
  String get activityMovies => 'Movies';

  @override
  String get activityDinner => 'Dinner';

  @override
  String get activityWalks => 'Walks';

  @override
  String get activityGamesSports => 'Games & Sports';

  @override
  String get activityExploreKochi => 'Explore Kochi';

  @override
  String get activityEvents => 'Events';

  @override
  String get activityStudyTogether => 'Study Together';

  @override
  String get activityCafe => 'Cafe';

  @override
  String get activityMore => 'More';

  @override
  String get recentMeetups => 'Recent meetups';

  @override
  String get viewHistory => 'View history';

  @override
  String distanceKm(double distance) {
    final intl.NumberFormat distanceNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String distanceString = distanceNumberFormat.format(distance);

    return '$distanceString km';
  }

  @override
  String ratingSummary(double rating, String label) {
    final intl.NumberFormat ratingNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String ratingString = ratingNumberFormat.format(rating);

    return '$ratingString ($label)';
  }

  @override
  String get ratingGreat => 'Great!';

  @override
  String get ratingGood => 'Good';

  @override
  String get safetyNotice =>
      'Approximate distance only · Meet in public places';

  @override
  String aiGreetingTitle(String name) {
    return 'Hi $name! 👋';
  }

  @override
  String get aiGreetingBody =>
      'What would you like to do today? I\'ll find the right person for you.';

  @override
  String get activityGaming => 'Gaming';

  @override
  String get activityShopping => 'Shopping';

  @override
  String get aiInterestsPrompt =>
      'Great! What are you interested in talking about? You can select multiple options.';

  @override
  String get interestTech => 'Tech';

  @override
  String get interestBusiness => 'Business';

  @override
  String get interestSports => 'Sports';

  @override
  String get interestTravel => 'Travel';

  @override
  String get interestMusic => 'Music';

  @override
  String get interestFood => 'Food';

  @override
  String get interestMovies => 'Movies';

  @override
  String get interestGaming => 'Gaming';

  @override
  String get interestBooks => 'Books';

  @override
  String get interestArt => 'Art';

  @override
  String get interestOther => 'Other';

  @override
  String get next => 'Next';

  @override
  String get aiDistancePrompt => 'How far would you like to meet someone?';

  @override
  String upToDistance(int distance) {
    return 'Up to $distance km';
  }

  @override
  String distanceTick(int distance) {
    return '$distance km';
  }

  @override
  String get aiTimePrompt => 'When are you planning to meet?';

  @override
  String get timeNow => 'Now';

  @override
  String get timeToday => 'Today';

  @override
  String get timeThisWeek => 'This Week';

  @override
  String get timeAnytime => 'Anytime';

  @override
  String get aiNotePrompt => 'Anything else I should know? (Optional)';

  @override
  String get noteHint =>
      'Example: casual conversation,\nnew in city, open to group meetups etc.';

  @override
  String noteCounter(int count) {
    return '$count/100';
  }

  @override
  String get findSomeoneCta => 'Find Someone';

  @override
  String get matchingTitleLine1 => 'Finding the right';

  @override
  String get matchingTitleLine2Lead => 'person ';

  @override
  String get matchingTitleLine2Accent => 'for you...';

  @override
  String matchingSubtitle(String activity) {
    return 'Our AI is finding someone who also wants to go for $activity and matches your interests.';
  }

  @override
  String get matchingStepInterests => 'Finding people with similar interests';

  @override
  String matchingStepDistance(int distance) {
    return 'Checking distance (within $distance km)';
  }

  @override
  String get matchingStepAvailability => 'Matching availability';

  @override
  String get matchingStepAlmost => 'Almost there...';

  @override
  String get matchFoundTitle => 'We found someone for you!';

  @override
  String matchFoundSubtitle(String activity) {
    return 'You both want to go for $activity, share similar interests and are nearby.';
  }

  @override
  String approxDistance(double distance) {
    final intl.NumberFormat distanceNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String distanceString = distanceNumberFormat.format(distance);

    return '~$distanceString km';
  }

  @override
  String approxDistanceAway(double distance) {
    final intl.NumberFormat distanceNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String distanceString = distanceNumberFormat.format(distance);

    return '~$distanceString km away';
  }

  @override
  String ageCityLine(int age, String city) {
    return '$age • $city';
  }

  @override
  String get wantsToGoFor => 'Wants to go for';

  @override
  String get commonInterests => 'Common Interests';

  @override
  String get connectNow => 'Connect Now';

  @override
  String get tryAnotherMatch => 'Try Another Match';

  @override
  String get noMatchYet =>
      'No match yet. Adjust your preferences and try again.';

  @override
  String get chatOnlineNow => 'Online now';

  @override
  String get chatTodayEvening => 'Today, Evening';

  @override
  String get chatToday => 'Today';

  @override
  String chatMatchedFor(String activity) {
    return 'You matched for $activity';
  }

  @override
  String get chatMatchBannerSubtitle => 'Feel free to chat and plan together!';

  @override
  String get chatViewMatchDetails => 'View Match Details';

  @override
  String get chatMessageHint => 'Type a message...';

  @override
  String get chatSendUnavailable =>
      'Messaging will be available once the backend is connected.';

  @override
  String get chatCallUnavailable =>
      'Calling will be available once the backend is connected.';

  @override
  String get chatCall => 'Call';

  @override
  String get chatAddAttachment => 'Add attachment';

  @override
  String get chatEmoji => 'Emoji';

  @override
  String get chatImage => 'Image';

  @override
  String get chatSend => 'Send voice message';

  @override
  String get chatConversationOptions => 'Conversation options';

  @override
  String get chatBlockReport => 'Block & report';
}
