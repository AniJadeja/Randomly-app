// start_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/pages.texts.dart';
import 'package:randomly/config/strings/buttons.dart';
import 'package:randomly/themes/themes.text.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
      body: SafeArea(
        child: Stack(
          children: [
            // Centered Logo & Title
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

            // Bottom-Aligned Button + Text
            Positioned(
              bottom: 24, // bottom margin
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonPrimary(
                    text: startScreenPrimaryButtonString,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: textTheme.bodySmall,
                        children: [
                          TextSpan(text: termsString1),

                          TextSpan(
                            text: termsString2,
                            style: textTheme.bodySmall?.copyWith(
                              // color: Colors.blue,
                              // decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  openUrl("https://example.com/terms"),
                          ),
                          TextSpan(text: termsString3),
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
                quarterTurns: 3, // 1 = 90°, 2 = 180°, 3 = 270°
                child: Text(verticalText, style: AppTextTheme.verticalText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
