import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_link.dart';
import 'package:randomly/components/buttons/button_outlined.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_text.dart';
import 'package:randomly/components/radio-buttons/radiobutton_gender.dart';
import 'package:randomly/components/sliders/vertical_slider_number.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/buttons.dart';
import 'package:randomly/config/strings/pages.texts.dart';
import 'package:randomly/pages/signup/gender_screen.dart';
import 'package:randomly/realm-db/models/deviceinfo/device_info.dart';
import 'package:randomly/realm-db/models/userdata/userdata.dart';
import 'package:randomly/realm-db/realm_config.dart';
import 'package:randomly/services/db-interaction/user_data_service.dart';
import 'package:randomly/services/db-interaction/user_device_info_service.dart';
import 'package:randomly/utils/user_device_info.dart';

class AgePickerScreen extends StatefulWidget {
  const AgePickerScreen({super.key});

  @override
  State<AgePickerScreen> createState() => _AgePickerScreenState();
}

class _AgePickerScreenState extends State<AgePickerScreen> {
  late GenderArgs args; // store once
  int selectedAge = 24;

  @override
  void initState() {
    super.initState();
    // Can't use ModalRoute.of(context) in initState directly
    // So we defer it to a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as GenderArgs;
      setState(() {
        args = routeArgs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    void onSelectedAgeChanged(int number) {
      setState(() {
        selectedAge = number;
        // debugPrint("New age : $selectedAge");
      });
    }

    return Scaffold(
      body: Column(
        children: [
          // Main Top Logo + Heading Bar
          Expanded(
            flex: 70,
            child: Padding(
              // padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
              padding: const EdgeInsets.fromLTRB(24, 90, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // spacing: 15, // This is not a valid property for Column
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(logoSvgPath, width: 80),
                  ),
                  const SizedBox(height: 15), // Use SizedBox for spacing
                  Text(appName, style: textTheme.displayLarge),
                ],
              ),
            ),
          ),

          // Age Picker + disclaimer
          Expanded(
            flex: 125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 32,
                  ),
                  child: Text(
                    ageDisclosureString,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                ),
                NumberPicker(onNumberChanged: onSelectedAgeChanged),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 32,
                  ),
                  child: Text(
                    actionWarningString,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),

          // Bottom buttons
          Expanded(
            flex: 57,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ButtonPrimary(
                    width: 245,
                    text: finishSignupButtonString,
                    onPressed: () {
                      getUserAndDeviceData(args.gender, selectedAge);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Stack(
                      children: [
                        ButtonText(
                          text: cancelButtonString,
                          onPressed: () {
                            SystemNavigator.pop(animated: true);
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
          ),
        ],
      ),
    );
  }

  SignUpApiPayload getUserAndDeviceData(Gender gender, int age) {
    return SignUpApiPayload(
      UserDeviceInfoService(context).fetchDeviceInfo(),
      gender.name,
      age,
    );
  }
}

class SignUpApiPayload {
  late String? info;
  late String gender;
  late int age;

  SignUpApiPayload(this.info, this.gender, this.age);
}
