import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/config/strings/buttons.dart';
import 'package:randomly/themes/themes.text.dart';

// An enum to represent the different gender options.
enum Gender { male, female }

/// A custom component for selecting a gender using SVG radio buttons.
///
/// This widget manages the state of the radio button group internally
/// and provides a simple 'onChanged' callback to the parent.
class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key, required this.onChanged});

  /// A callback that is called when a gender is selected.
  /// It returns the selected Gender value.
  final ValueChanged<Gender> onChanged;

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  // The state variable to hold the currently selected gender.
  // It is nullable to represent the initial state where nothing is selected.
  Gender? _selectedGender;

  // This function is called when a radio button is tapped.
  // It updates the internal state and notifies the parent via the callback.
  void _selectGender(Gender gender) {
    // Only update if the selected gender is different.
    if (_selectedGender != gender) {
      setState(() {
        _selectedGender = gender;
      });
      // Call the parent's onChanged callback with the new value.
      widget.onChanged(gender);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Male Radio Button
        GestureDetector(
          onTap: () => _selectGender(Gender.male),
          child: Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              SvgPicture.asset(
                _selectedGender == Gender.male
                    ? checkedMaleBackPath
                    : uncheckedMaleBackPath,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 0,
                ),
                child: Text(
                  genderMaleButtonString,
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        // Female Radio Button
        GestureDetector(
          onTap: () => _selectGender(Gender.female),
          child: Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              SvgPicture.asset(
                _selectedGender == Gender.female
                    ? checkedFemaleBackPath
                    : uncheckedFemaleBackPath,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 0,
                ),
                child: Text(
                  genderFemaleButtonString,
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
