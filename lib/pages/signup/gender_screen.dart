// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:randomly/config/paths.dart';
// // Your original GenderPickerScreen, now as a StatefulWidget.
// class GenderPickerScreen extends StatefulWidget {
//   const GenderPickerScreen({super.key});
//
//   @override
//   State<GenderPickerScreen> createState() => _GenderPickerScreenState();
// }
//
// class _GenderPickerScreenState extends State<GenderPickerScreen> {
//   // A state variable to store the selected gender from the GenderSelector.
//   Gender? _selectedGender;
//
//   // A function to handle the gender change from the GenderSelector.
//   void _onGenderChanged(Gender gender) {
//     setState(() {
//       _selectedGender = gender;
//     });
//     print('Selected gender from the parent: $_selectedGender');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gender Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Please select your gender:',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 20),
//             // The GenderSelector widget is used here.
//             GenderSelector(
//               onChanged: _onGenderChanged,
//             ),
//             const SizedBox(height: 20),
//             // Display the selected gender.
//             Text(
//               'Selected: ${_selectedGender?.name.toUpperCase() ?? 'None'}',
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             // SvgPicture.asset(checkedFemaleBackPath),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_link.dart';
import 'package:randomly/components/buttons/button_outlined.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_text.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/buttons.dart';
import 'package:randomly/config/strings/pages.texts.dart';
import 'package:randomly/components/radio-buttons/radiobutton_gender.dart';

class GenderPickerScreen extends StatefulWidget {
  const GenderPickerScreen({super.key});

  @override
  State<GenderPickerScreen> createState() => _GenderPickerScreenState();
}

class _GenderPickerScreenState extends State<GenderPickerScreen> {
  @override
  Widget build(BuildContext context) {
    // A state variable to store the selected gender from the GenderSelector.
    Gender? _selectedGender;

    // A function to handle the gender change from the GenderSelector.
    void _onGenderChanged(Gender gender) {
      setState(() {
        _selectedGender = gender;
      });
      print('Selected gender from the parent: $_selectedGender');
    }

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Column(
        children: [
          // Main Top Logo + Heading Bar
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 15,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(logoSvgPath, width: 80),
                  ),
                  Text(appName, style: textTheme.displayLarge),
                ],
              ),
            ),
          ),


          // Background Image + disclaimer
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 32),
                  child: Text(
                    genderDisclosureString,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                ),
                Column(
                  spacing: 30,
                  children: [
                    Text(
                      genderSelectorInstruction,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge,
                    ),
                    // The GenderSelector widget is used here.
                    GenderSelector(onChanged: _onGenderChanged),
                  ],
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 24),
                  child: Row(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonOutlined(text: otherButtonString, onPressed: () {}),
                      ButtonPrimary(text: nextButtonString, onPressed: () {}),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Stack(
                    children: [
                      ButtonText(text: cancelButtonString, onPressed: () {}),
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
