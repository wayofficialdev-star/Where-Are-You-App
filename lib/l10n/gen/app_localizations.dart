import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @findSomeone.
  ///
  /// In en, this message translates to:
  /// **'FIND SOMEONE'**
  String get findSomeone;

  /// No description provided for @findSomeoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search for people around you and start your next meeting.'**
  String get findSomeoneSubtitle;

  /// No description provided for @findSomeoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Someone'**
  String get findSomeoneTitle;

  /// No description provided for @meetingHistory.
  ///
  /// In en, this message translates to:
  /// **'Meeting history'**
  String get meetingHistory;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelLabel(int level);

  /// No description provided for @xpValue.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String xpValue(int xp);

  /// No description provided for @coinsValue.
  ///
  /// In en, this message translates to:
  /// **'{coins} Coins'**
  String coinsValue(int coins);

  /// No description provided for @xpToNextLevel.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP to next level'**
  String xpToNextLevel(int xp);

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}!'**
  String homeGreeting(String name);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No new notifications yet.'**
  String get notificationsEmpty;

  /// No description provided for @meetings.
  ///
  /// In en, this message translates to:
  /// **'Meetings'**
  String get meetings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @searchPeopleHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or interest'**
  String get searchPeopleHint;

  /// No description provided for @noPeopleNearby.
  ///
  /// In en, this message translates to:
  /// **'No one nearby yet. Try a different search.'**
  String get noPeopleNearby;

  /// No description provided for @kmAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String kmAway(double distance);

  /// No description provided for @noMeetingsYet.
  ///
  /// In en, this message translates to:
  /// **'Your meetings will show up here.'**
  String get noMeetingsYet;

  /// No description provided for @backendNotConnected.
  ///
  /// In en, this message translates to:
  /// **'This action will be available once the backend is connected.'**
  String get backendNotConnected;

  /// No description provided for @signUpTitleLead.
  ///
  /// In en, this message translates to:
  /// **'Create Your'**
  String get signUpTitleLead;

  /// No description provided for @signUpTitleAccent.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get signUpTitleAccent;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join Where R U and start making new friends nearby.'**
  String get signUpSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Location (Optional)'**
  String get locationLabel;

  /// No description provided for @signUpAction.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpAction;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logInAction.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logInAction;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueWithFacebook;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @logInComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Log in will be available once authentication is connected.'**
  String get logInComingSoon;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}! 👋'**
  String goodMorning(String name);

  /// No description provided for @readyToMakeAPlan.
  ///
  /// In en, this message translates to:
  /// **'Ready to make a plan?'**
  String get readyToMakeAPlan;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @findAMatch.
  ///
  /// In en, this message translates to:
  /// **'Find a Match'**
  String get findAMatch;

  /// No description provided for @findAMatchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find someone nearby who\'s up for the same thing, right now.'**
  String get findAMatchSubtitle;

  /// No description provided for @rightNow.
  ///
  /// In en, this message translates to:
  /// **'Right now'**
  String get rightNow;

  /// No description provided for @withinOneHour.
  ///
  /// In en, this message translates to:
  /// **'Within 1 hour'**
  String get withinOneHour;

  /// No description provided for @laterToday.
  ///
  /// In en, this message translates to:
  /// **'Later today'**
  String get laterToday;

  /// No description provided for @scheduledTime.
  ///
  /// In en, this message translates to:
  /// **'Scheduled time'**
  String get scheduledTime;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @meetups.
  ///
  /// In en, this message translates to:
  /// **'Meetups'**
  String get meetups;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @whatAreYouUpFor.
  ///
  /// In en, this message translates to:
  /// **'What are you up for?'**
  String get whatAreYouUpFor;

  /// No description provided for @activityTeaCoffee.
  ///
  /// In en, this message translates to:
  /// **'Tea / Coffee'**
  String get activityTeaCoffee;

  /// No description provided for @activityMovies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get activityMovies;

  /// No description provided for @activityDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get activityDinner;

  /// No description provided for @activityWalks.
  ///
  /// In en, this message translates to:
  /// **'Walks'**
  String get activityWalks;

  /// No description provided for @activityGamesSports.
  ///
  /// In en, this message translates to:
  /// **'Games & Sports'**
  String get activityGamesSports;

  /// No description provided for @activityExploreKochi.
  ///
  /// In en, this message translates to:
  /// **'Explore Kochi'**
  String get activityExploreKochi;

  /// No description provided for @activityEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get activityEvents;

  /// No description provided for @activityStudyTogether.
  ///
  /// In en, this message translates to:
  /// **'Study Together'**
  String get activityStudyTogether;

  /// No description provided for @activityCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get activityCafe;

  /// No description provided for @activityMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get activityMore;

  /// No description provided for @recentMeetups.
  ///
  /// In en, this message translates to:
  /// **'Recent meetups'**
  String get recentMeetups;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View history'**
  String get viewHistory;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKm(double distance);

  /// No description provided for @ratingSummary.
  ///
  /// In en, this message translates to:
  /// **'{rating} ({label})'**
  String ratingSummary(double rating, String label);

  /// No description provided for @ratingGreat.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get ratingGreat;

  /// No description provided for @ratingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get ratingGood;

  /// No description provided for @safetyNotice.
  ///
  /// In en, this message translates to:
  /// **'Approximate distance only · Meet in public places'**
  String get safetyNotice;

  /// No description provided for @aiGreetingTitle.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}! 👋'**
  String aiGreetingTitle(String name);

  /// No description provided for @aiGreetingBody.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do today? I\'ll find the right person for you.'**
  String get aiGreetingBody;

  /// No description provided for @activityGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get activityGaming;

  /// No description provided for @activityShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get activityShopping;

  /// No description provided for @aiInterestsPrompt.
  ///
  /// In en, this message translates to:
  /// **'Great! What are you interested in talking about? You can select multiple options.'**
  String get aiInterestsPrompt;

  /// No description provided for @interestTech.
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get interestTech;

  /// No description provided for @interestBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get interestBusiness;

  /// No description provided for @interestSports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get interestSports;

  /// No description provided for @interestTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get interestTravel;

  /// No description provided for @interestMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get interestMusic;

  /// No description provided for @interestFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get interestFood;

  /// No description provided for @interestMovies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get interestMovies;

  /// No description provided for @interestGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get interestGaming;

  /// No description provided for @interestBooks.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get interestBooks;

  /// No description provided for @interestArt.
  ///
  /// In en, this message translates to:
  /// **'Art'**
  String get interestArt;

  /// No description provided for @interestOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get interestOther;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @aiDistancePrompt.
  ///
  /// In en, this message translates to:
  /// **'How far would you like to meet someone?'**
  String get aiDistancePrompt;

  /// No description provided for @upToDistance.
  ///
  /// In en, this message translates to:
  /// **'Up to {distance} km'**
  String upToDistance(int distance);

  /// No description provided for @distanceTick.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceTick(int distance);

  /// No description provided for @aiTimePrompt.
  ///
  /// In en, this message translates to:
  /// **'When are you planning to meet?'**
  String get aiTimePrompt;

  /// No description provided for @timeNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get timeNow;

  /// No description provided for @timeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get timeToday;

  /// No description provided for @timeThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get timeThisWeek;

  /// No description provided for @timeAnytime.
  ///
  /// In en, this message translates to:
  /// **'Anytime'**
  String get timeAnytime;

  /// No description provided for @aiNotePrompt.
  ///
  /// In en, this message translates to:
  /// **'Anything else I should know? (Optional)'**
  String get aiNotePrompt;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Example: casual conversation,\nnew in city, open to group meetups etc.'**
  String get noteHint;

  /// No description provided for @noteCounter.
  ///
  /// In en, this message translates to:
  /// **'{count}/100'**
  String noteCounter(int count);

  /// No description provided for @findSomeoneCta.
  ///
  /// In en, this message translates to:
  /// **'Find Someone'**
  String get findSomeoneCta;

  /// No description provided for @matchingTitleLine1.
  ///
  /// In en, this message translates to:
  /// **'Finding the right'**
  String get matchingTitleLine1;

  /// No description provided for @matchingTitleLine2Lead.
  ///
  /// In en, this message translates to:
  /// **'person '**
  String get matchingTitleLine2Lead;

  /// No description provided for @matchingTitleLine2Accent.
  ///
  /// In en, this message translates to:
  /// **'for you...'**
  String get matchingTitleLine2Accent;

  /// No description provided for @matchingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our AI is finding someone who also wants to go for {activity} and matches your interests.'**
  String matchingSubtitle(String activity);

  /// No description provided for @matchingStepInterests.
  ///
  /// In en, this message translates to:
  /// **'Finding people with similar interests'**
  String get matchingStepInterests;

  /// No description provided for @matchingStepDistance.
  ///
  /// In en, this message translates to:
  /// **'Checking distance (within {distance} km)'**
  String matchingStepDistance(int distance);

  /// No description provided for @matchingStepAvailability.
  ///
  /// In en, this message translates to:
  /// **'Matching availability'**
  String get matchingStepAvailability;

  /// No description provided for @matchingStepAlmost.
  ///
  /// In en, this message translates to:
  /// **'Almost there...'**
  String get matchingStepAlmost;

  /// No description provided for @matchFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'We found someone for you!'**
  String get matchFoundTitle;

  /// No description provided for @matchFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You both want to go for {activity}, share similar interests and are nearby.'**
  String matchFoundSubtitle(String activity);

  /// No description provided for @approxDistance.
  ///
  /// In en, this message translates to:
  /// **'~{distance} km'**
  String approxDistance(double distance);

  /// No description provided for @approxDistanceAway.
  ///
  /// In en, this message translates to:
  /// **'~{distance} km away'**
  String approxDistanceAway(double distance);

  /// No description provided for @ageCityLine.
  ///
  /// In en, this message translates to:
  /// **'{age} • {city}'**
  String ageCityLine(int age, String city);

  /// No description provided for @wantsToGoFor.
  ///
  /// In en, this message translates to:
  /// **'Wants to go for'**
  String get wantsToGoFor;

  /// No description provided for @commonInterests.
  ///
  /// In en, this message translates to:
  /// **'Common Interests'**
  String get commonInterests;

  /// No description provided for @connectNow.
  ///
  /// In en, this message translates to:
  /// **'Connect Now'**
  String get connectNow;

  /// No description provided for @tryAnotherMatch.
  ///
  /// In en, this message translates to:
  /// **'Try Another Match'**
  String get tryAnotherMatch;

  /// No description provided for @noMatchYet.
  ///
  /// In en, this message translates to:
  /// **'No match yet. Adjust your preferences and try again.'**
  String get noMatchYet;

  /// No description provided for @chatOnlineNow.
  ///
  /// In en, this message translates to:
  /// **'Online now'**
  String get chatOnlineNow;

  /// No description provided for @chatTodayEvening.
  ///
  /// In en, this message translates to:
  /// **'Today, Evening'**
  String get chatTodayEvening;

  /// No description provided for @chatToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chatToday;

  /// No description provided for @chatMatchedFor.
  ///
  /// In en, this message translates to:
  /// **'You matched for {activity}'**
  String chatMatchedFor(String activity);

  /// No description provided for @chatMatchBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Feel free to chat and plan together!'**
  String get chatMatchBannerSubtitle;

  /// No description provided for @chatViewMatchDetails.
  ///
  /// In en, this message translates to:
  /// **'View Match Details'**
  String get chatViewMatchDetails;

  /// No description provided for @chatMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get chatMessageHint;

  /// No description provided for @chatSendUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Messaging will be available once the backend is connected.'**
  String get chatSendUnavailable;

  /// No description provided for @chatCallUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Calling will be available once the backend is connected.'**
  String get chatCallUnavailable;

  /// No description provided for @chatCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get chatCall;

  /// No description provided for @chatAddAttachment.
  ///
  /// In en, this message translates to:
  /// **'Add attachment'**
  String get chatAddAttachment;

  /// No description provided for @chatEmoji.
  ///
  /// In en, this message translates to:
  /// **'Emoji'**
  String get chatEmoji;

  /// No description provided for @chatImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get chatImage;

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send voice message'**
  String get chatSend;

  /// No description provided for @chatConversationOptions.
  ///
  /// In en, this message translates to:
  /// **'Conversation options'**
  String get chatConversationOptions;

  /// No description provided for @chatBlockReport.
  ///
  /// In en, this message translates to:
  /// **'Block & report'**
  String get chatBlockReport;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
