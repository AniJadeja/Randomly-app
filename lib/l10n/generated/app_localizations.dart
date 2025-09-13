import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('fr'),
    Locale('ja'),
  ];

  /// No description provided for @helloString.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get helloString;

  /// No description provided for @letsStartString.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get letsStartString;

  /// No description provided for @restoreAccountString.
  ///
  /// In en, this message translates to:
  /// **'Restore Account'**
  String get restoreAccountString;

  /// No description provided for @randomlyIntroString.
  ///
  /// In en, this message translates to:
  /// **'Randomly connects people from all around the globe anonymously and securely'**
  String get randomlyIntroString;

  /// No description provided for @iUnderstandButtonText.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get iUnderstandButtonText;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Although people get connected anonymously, to maintain the integrity of the chat, gender and age is required.'**
  String get disclaimer;

  /// No description provided for @restoreAccountInstructionString.
  ///
  /// In en, this message translates to:
  /// **'To restore your account, provide your keyfile and optionally chat backup file.'**
  String get restoreAccountInstructionString;

  /// No description provided for @keyfileButtonString.
  ///
  /// In en, this message translates to:
  /// **'Your Key file'**
  String get keyfileButtonString;

  /// No description provided for @keyfileDescriptionString.
  ///
  /// In en, this message translates to:
  /// **'Keyfile provides identity of your account.'**
  String get keyfileDescriptionString;

  /// No description provided for @chatBackupButtonString.
  ///
  /// In en, this message translates to:
  /// **'Your Chat file'**
  String get chatBackupButtonString;

  /// No description provided for @chatBackupDescriptionString.
  ///
  /// In en, this message translates to:
  /// **'Chat Backup provides all the previous chats of your account.'**
  String get chatBackupDescriptionString;

  /// No description provided for @knowMoreString.
  ///
  /// In en, this message translates to:
  /// **'To know more '**
  String get knowMoreString;

  /// No description provided for @clickHereString.
  ///
  /// In en, this message translates to:
  /// **'Click Here'**
  String get clickHereString;

  /// No description provided for @clearButtonString.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButtonString;

  /// No description provided for @genderDisclosureString.
  ///
  /// In en, this message translates to:
  /// **'Disclosing your gender helps build trust among community and maintains integrity of subsequent chats.'**
  String get genderDisclosureString;

  /// No description provided for @genderSelectorInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get genderSelectorInstruction;

  /// No description provided for @otherButtonString.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherButtonString;

  /// No description provided for @nextButtonString.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButtonString;

  /// No description provided for @genderMaleButtonString.
  ///
  /// In en, this message translates to:
  /// **'I am Male'**
  String get genderMaleButtonString;

  /// No description provided for @genderFemaleButtonString.
  ///
  /// In en, this message translates to:
  /// **'I am Female'**
  String get genderFemaleButtonString;

  /// No description provided for @ageDisclosureString.
  ///
  /// In en, this message translates to:
  /// **'This platform is restricted to people of age 18 and above. Thus disclosure of age is required.'**
  String get ageDisclosureString;

  /// No description provided for @actionWarningString.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. You may not change your age later and your age will remain invisible to others.'**
  String get actionWarningString;

  /// No description provided for @finishSignupButtonString.
  ///
  /// In en, this message translates to:
  /// **'Finish Signup'**
  String get finishSignupButtonString;

  /// No description provided for @cancelSignupButtonString.
  ///
  /// In en, this message translates to:
  /// **'Cancel Signup'**
  String get cancelSignupButtonString;

  /// No description provided for @policyButtonString.
  ///
  /// In en, this message translates to:
  /// **'Policy'**
  String get policyButtonString;

  /// No description provided for @verticalGreetText.
  ///
  /// In en, this message translates to:
  /// **'Meet People from everywhere-->'**
  String get verticalGreetText;

  /// No description provided for @termsString1.
  ///
  /// In en, this message translates to:
  /// **'By using the app you agree to our, '**
  String get termsString1;

  /// No description provided for @termsString2.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service.'**
  String get termsString2;
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
      <String>['en', 'es', 'fr', 'ja'].contains(locale.languageCode);

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
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
