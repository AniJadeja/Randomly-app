// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get helloString => 'こんにちは';

  @override
  String get letsStartString => '始めましょう';

  @override
  String get restoreAccountString => 'アカウントを復元する';

  @override
  String get randomlyIntroString => '世界中の人々を匿名かつ安全にランダムに接続します';

  @override
  String get iUnderstandButtonText => 'わかりました';

  @override
  String get disclaimer => '人々は匿名でつながりますが、チャットの完全性を維持するために、性別と年齢は必須です。';

  @override
  String get restoreAccountInstructionString =>
      'アカウントを復元するには、キーファイルと、オプションでチャット バックアップ ファイルを提供します。';

  @override
  String get keyfileButtonString => 'キーファイル';

  @override
  String get keyfileDescriptionString => 'キーファイルはアカウントの ID を提供します。';

  @override
  String get chatBackupButtonString => 'チャットファイル';

  @override
  String get chatBackupDescriptionString =>
      'チャット バックアップでは、アカウントの過去のチャットがすべて提供されます。';

  @override
  String get knowMoreString => 'さらに詳しく知るには';

  @override
  String get clickHereString => 'ここをクリック';

  @override
  String get clearButtonString => 'クリア';

  @override
  String get genderDisclosureString =>
      '性別を明らかにすることは、コミュニティ内での信頼関係の構築に役立ち、その後のチャットの整合性を維持します。';

  @override
  String get genderSelectorInstruction => '性別を選択してください';

  @override
  String get otherButtonString => '他の';

  @override
  String get nextButtonString => '次';

  @override
  String get genderMaleButtonString => '私は男性です';

  @override
  String get genderFemaleButtonString => '私は女性です';

  @override
  String get ageDisclosureString =>
      'このプラットフォームは18歳以上の方のみご利用いただけます。年齢の開示が必須となります。';

  @override
  String get actionWarningString =>
      'この操作は元に戻せません。後から年齢を変更することはできません。また、年齢は他のユーザーからは見えなくなります。';

  @override
  String get finishSignupButtonString => 'サインアップを完了する';

  @override
  String get cancelSignupButtonString => 'サインアップをキャンセル';

  @override
  String get policyButtonString => 'ポリシー';

  @override
  String get verticalGreetText => '世界中の人々と出会う-->';

  @override
  String get termsString1 => 'アプリを使用することで、お客様は当社の、';

  @override
  String get termsString2 => '利用規約。';
}
