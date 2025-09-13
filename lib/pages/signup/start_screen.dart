// start_screen.dart

import 'dart:math';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_text.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/buttons.dart';
import 'package:randomly/config/strings/pages.texts.dart';
import 'package:randomly/config/strings/routes.dart';
import 'package:randomly/navigation/preload_manager.dart';
import 'package:randomly/pages/signup/intro_screen.dart';
import 'package:randomly/services/db-interaction/user_device_info_service.dart';
import 'package:randomly/themes/themes.text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:randomly/l10n/generated/app_localizations.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      UserDeviceInfoService service = UserDeviceInfoService(context);
      service.registerDeviceInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreloadManager(
      routesToPreload: {introScreenRoute: (_) => IntroScreen()},
      child: _startScreenWidget(),
    );
  }

  Widget _startScreenWidget() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final lang = AppLocalizations.of(context)!;

    Future<void> openUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw '$couldNotLaunchUrlError $url';
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(logoSvgPath, width: 70),
                const SizedBox(height: 16),
                Text(appName, style: textTheme.displayLarge),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonPrimary(
                  text: lang.letsStartString,
                  width: 245,
                  onPressed: () {
                    Navigator.pushNamed(context, introScreenRoute);
                  },
                ),
                const SizedBox(height: 16),
                ButtonText(
                  text: lang.restoreAccountString,
                  onPressed: () {
                    Navigator.pushNamed(context, restoreScreenRoute);
                  },
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.bodySmall,
                      children: [
                        TextSpan(text: lang.termsString1),
                        TextSpan(
                          text: lang.termsString2,
                          style: textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                openUrl("https://example.com/terms"),
                        ),
                        // TextSpan(text: termsString3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 32,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(lang.verticalGreetText, style: AppTextTheme.verticalText),
            ),
          ),
        ],
      ),
    );
  }
}
