import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_link.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_text.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/buttons.dart';
import 'package:randomly/config/strings/pages.texts.dart';
import 'package:randomly/config/strings/routes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
                randomlyIntroString,
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
                    primaryAccent.withAlpha(80),
                    BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  bottom: 64,
                  right: 32,
                  left: 32,
                  child: Text(
                    disclaimer,
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
                  text: iUnderstandButtonText,
                  width: 245,
                  onPressed: () {
                    Navigator.pushNamed(context, startScreenRoute);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Stack(
                    children: [
                      ButtonText(
                        text: cancelButtonString,
                        onPressed: () {
                          Navigator.pushNamed(context, startScreenRoute);
                        },
                      ),
                      Positioned(
                        right: 24,
                        child: ButtonLink(
                          text: policyButtonString,
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
