import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_link.dart';
import 'package:randomly/components/buttons/button_outlined.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_text.dart';
import 'package:randomly/components/radio-buttons/radio_button_outlined.dart';
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
  // A state variable to store the selected gender from the GenderSelector.
  Gender? _selectedGender;
  bool _otherSelected = false;

  final GlobalKey<GenderSelectorState> _genderSelectorKey = GlobalKey<GenderSelectorState>();


  // A function to handle the gender change from the GenderSelector.
  void _onGenderChanged(Gender gender) {
    setState(() {
      _selectedGender = gender;
      _otherSelected = false; // reset visual state
    });
    print('Selected gender from the parent: $_selectedGender');
  }

  // A new method to clear the gender selection.
  void _clearGenderSelection() {
    _genderSelectorKey.currentState?.clearSelection();
    setState(() {
      _selectedGender = null;
    });
  }


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
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
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
                  // spacing: 30, // This is not a valid property for Column
                  children: [
                    Text(
                      genderSelectorInstruction,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 30), // Use SizedBox for spacing
                    // The GenderSelector widget is used here.
                    GenderSelector(
                      key: _genderSelectorKey,
                      onChanged: _onGenderChanged,
                    ),                  ],
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
                    spacing: 15, // This is not a valid property for Row
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonOutlinedRadio(
                        text: otherButtonString,
                        isSelected: _otherSelected,
                        onPressed: () {
                          setState(() {
                            _otherSelected = true;
                          });
                          _clearGenderSelection();
                        },
                      ),
                      Expanded(
                          child: ButtonPrimary(text: nextButtonString, onPressed: () {})),
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