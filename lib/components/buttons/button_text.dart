// button_text.dart

import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

class ButtonText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // primary button size
  static Size textButtonSize = Size(245, 50);

  static ButtonStyle textButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(primaryAccent.withAlpha(15)),
    fixedSize: WidgetStateProperty.all(textButtonSize),
  );

  const ButtonText({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // The SizedBox is defined here to give the button a consistent, fixed size.
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        style: textButtonStyle,
        onPressed: onPressed,
        child: Text(text, style: AppTextTheme.textButtonPrimary),
      ),
    );
  }
}
