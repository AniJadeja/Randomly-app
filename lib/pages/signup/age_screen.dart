import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'package:randomly/l10n/generated/app_localizations.dart';
import 'package:randomly/pages/signup/gender_screen.dart';
import 'package:randomly/realm-db/models/deviceinfo/device_info.dart';
import 'package:randomly/realm-db/models/userdata/userdata.dart';
import 'package:randomly/realm-db/realm_config.dart';
import 'package:randomly/services/db-interaction/user_data_service.dart';
import 'package:randomly/services/db-interaction/user_device_info_service.dart';
import 'package:randomly/utils/user_device_info.dart';
import 'package:http/http.dart' as http; // Import the http package


class AgePickerScreen extends StatefulWidget {
  const AgePickerScreen({super.key});

  @override
  State<AgePickerScreen> createState() => _AgePickerScreenState();
}

class _AgePickerScreenState extends State<AgePickerScreen> {
  late GenderArgs args; // store once
  int selectedAge = 24;

  bool _isLoading = false; // Added for loading state
  String _statusMessage = ''; // Added for status message


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

// Updated _sendPostRequest method
  Future<void> _sendPostRequest() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Registering...';
    });

    final signUpPayload = getUserAndDeviceData(args.gender, selectedAge);

    // Create the properly structured request body
    final Map<String, dynamic> requestBody = {};

    if (signUpPayload.info != null) {
      try {
        final Map<String, dynamic> deviceInfoMap = jsonDecode(signUpPayload.info!);

        requestBody['timeZone'] = deviceInfoMap['timeZone'];

        // Create nested DeviceInfo object
        requestBody['deviceInfo'] = {
          'screenResolution': deviceInfoMap['screenResolution'],
          'os': deviceInfoMap['os'],
          'manufacturer': deviceInfoMap['manufacturer'],
          'osVersion': deviceInfoMap['osVersion'],
          'api': deviceInfoMap['api'],
          'identifier': deviceInfoMap['identifier'],
          'model': deviceInfoMap['model'],
        };

      } catch (e) {
        debugPrint('Error decoding device info JSON: $e');
      }
    }

    // Add user data
    requestBody['gender'] = signUpPayload.gender;
    requestBody['age'] = signUpPayload.age;

    // Get the base URL and endpoint from .env
    final String baseUrl = dotenv.env['BASE_API_URL'] ?? 'http://10.0.2.2:680';
    final String registerEndpoint = dotenv.env['REGISTER_ENDPOINT'] ?? '/auth/register';
    final url = Uri.parse('$baseUrl$registerEndpoint');

    try {
      debugPrint("Final Url : $url");
      debugPrint("Request Body: ${jsonEncode(requestBody)}"); // Add this to see the final structure

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _statusMessage = 'Success!';
        });
        debugPrint('Registration successful! Response: ${response.body}');
        // You can navigate to the next screen here
      } else {
        setState(() {
          _statusMessage = 'Registration failed. Status: ${response.statusCode}';
        });
        debugPrint('Registration failed. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Network error: $e';
      });
      debugPrint('Network error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final lang = AppLocalizations.of(context)!;


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
                    lang.ageDisclosureString,
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
                    lang.actionWarningString,
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
                    text: lang.finishSignupButtonString,
                    onPressed: () {
                      // getUserAndDeviceData(args.gender, selectedAge);
                      _sendPostRequest();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Stack(
                      children: [
                        ButtonText(
                          text: lang.cancelSignupButtonString,
                          onPressed: () {
                            SystemNavigator.pop(animated: true);
                          },
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
          ),
        ],
      ),
    );
  }

  SignUpApiPayload getUserAndDeviceData(Gender gender, int age) {
    debugPrint(SignUpApiPayload(
      UserDeviceInfoService(context).fetchDeviceInfo(),
      gender.name,
      age,
    ).info);

    debugPrint(SignUpApiPayload(
      UserDeviceInfoService(context).fetchDeviceInfo(),
      gender.name,
      age,
    ).gender);

    debugPrint(SignUpApiPayload(
      UserDeviceInfoService(context).fetchDeviceInfo(),
      gender.name,
      age,
    ).age.toString());

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
