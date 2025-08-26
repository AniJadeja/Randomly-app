// button_primary.dart

import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const ButtonPrimary({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the button's final width. Defaults to full width (double.infinity) if null.
    final double buttonWidth = width ?? double.infinity;
    // Determine the button's final height. Defaults to 50.0 if null.
    final double buttonHeight = height ?? 50.0;

    final ButtonStyle primaryButtonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all(primaryAccent),
      elevation: WidgetStateProperty.all(5.0),
      overlayColor: WidgetStateProperty.all(primaryAccent.withAlpha(15)),
      shadowColor: WidgetStateProperty.all(buttonShadow),
      fixedSize: WidgetStateProperty.all(Size(buttonWidth, buttonHeight)),
    );

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        style: primaryButtonStyle,
        onPressed: onPressed,
        child: Text(text, style: AppTextTheme.textButtonPrimary),
      ),
    );
  }
}