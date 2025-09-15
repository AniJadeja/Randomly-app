import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_link.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_secondary.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/routes.dart';
import 'package:randomly/l10n/generated/app_localizations.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          // Main Top Logo + Heading Bar
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  SvgPicture.asset(logoSvgPath, width: 30),
                  Text(appName, style: textTheme.displayMedium),
                ],
              ),
            ),
          ),

          // Randomly Intro Screen Text
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
              child: Text(
                lang.randomlyIntroString,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
            ),
          ),

          // Background Image + disclaimer
          Expanded(
            flex: 5,
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                SvgPicture.asset(
                  width: double.infinity,
                  mapSvgPath,
                  colorFilter: ColorFilter.mode(
                    primaryWhite.withAlpha(10),
                    BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  bottom: 64,
                  right: 32,
                  left: 32,
                  child: Text(
                    lang.disclaimer,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),

          // Bottom buttons
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonPrimary(
                  text: lang.iUnderstandButtonText,
                  width: 245,
                  onPressed: () {
                    Navigator.pushNamed(context, genderScreenRoute);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
                  child: Stack(
                    children: [
                      ButtonSecondary(
                        text: lang.cancelSignupButtonString,
                        onPressed: () {
                          SystemNavigator.pop(animated: true);
                        },
                        isCancelAction: true,
                      ),
                      Positioned(
                        right: 24,
                        child: ButtonLink(
                          text: lang.policyButtonString,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
