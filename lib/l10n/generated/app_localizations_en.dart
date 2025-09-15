// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloString => 'Hello';

  @override
  String get letsStartString => 'Let\'s Start';

  @override
  String get restoreAccountString => 'Restore Account';

  @override
  String get randomlyIntroString =>
      'Randomly connects people from all around the globe anonymously and securely';

  @override
  String get iUnderstandButtonText => 'I Understand';

  @override
  String get disclaimer =>
      'Although people get connected anonymously, to maintain the integrity of the chat, gender and age is required.';

  @override
  String get restoreAccountInstructionString =>
      'To restore your account, provide your keyfile and optionally chat backup file.';

  @override
  String get keyfileButtonString => 'Your Key file';

  @override
  String get keyfileDescriptionString =>
      'Keyfile provides identity of your account.';

  @override
  String get chatBackupButtonString => 'Your Chat file';

  @override
  String get chatBackupDescriptionString =>
      'Chat Backup provides all the previous chats of your account.';

  @override
  String get knowMoreString => 'To know more ';

  @override
  String get clickHereString => 'Click Here';

  @override
  String get clearButtonString => 'Clear';

  @override
  String get cancelRestoreButtonString => 'Cancel Restore';

  @override
  String get enterPasswordHintString => 'Enter Your Password Here...';

  @override
  String get fileError5KBString => 'File is too large. Max size is 5KB.';

  @override
  String get keyFileProtectionString =>
      'This keyfile is protected by user password';

  @override
  String get genderDisclosureString =>
      'Disclosing your gender helps build trust among community and maintains integrity of subsequent chats.';

  @override
  String get genderSelectorInstruction => 'Please select your gender';

  @override
  String get otherButtonString => 'Other';

  @override
  String get nextButtonString => 'Next';

  @override
  String get genderMaleButtonString => 'I am Male';

  @override
  String get genderFemaleButtonString => 'I am Female';

  @override
  String get ageDisclosureString =>
      'This platform is restricted to people of age 18 and above. Thus disclosure of age is required.';

  @override
  String get actionWarningString =>
      'This action is irreversible. You may not change your age later and your age will remain invisible to others.';

  @override
  String get finishSignupButtonString => 'Finish Signup';

  @override
  String get cancelSignupButtonString => 'Cancel Signup';

  @override
  String get policyButtonString => 'Policy';

  @override
  String get verticalGreetText => 'Meet People from everywhere-->';

  @override
  String get termsString1 => 'By using the app you agree to our, ';

  @override
  String get termsString2 => 'Terms of Service.';
}
