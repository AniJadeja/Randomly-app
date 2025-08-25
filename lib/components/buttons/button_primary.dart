// button_primary.dart

import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // primary button size
  static Size primaryButtonSize = Size(245, 50);

  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(primaryAccent),
    elevation: WidgetStateProperty.all(5.0),
    overlayColor: WidgetStateProperty.all(Colors.purpleAccent.withAlpha(15)),
    shadowColor: WidgetStateProperty.all(buttonShadow),
    fixedSize: WidgetStateProperty.all(primaryButtonSize),
  );

  const ButtonPrimary({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // The SizedBox is defined here to give the button a consistent, fixed size.
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: primaryButtonStyle,
        onPressed: onPressed,
        child: Text(text, style: AppTextTheme.textButtonPrimary),
      ),
    );
  }
}
