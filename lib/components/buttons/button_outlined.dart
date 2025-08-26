// button_outlined.dart

import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

class ButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const ButtonOutlined({
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

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final ButtonStyle primaryButtonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all(theme.scaffoldBackgroundColor),
      overlayColor: WidgetStateProperty.all(primaryAccent.withAlpha(15)),
      fixedSize: WidgetStateProperty.all(Size(buttonWidth, buttonHeight)),
    );

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: textTheme.bodySmall!.color!.withAlpha(150), // Change color as needed
            width: 2.0, // Change width as needed
          ),
          borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
        ),
        child: ElevatedButton(
          style: primaryButtonStyle,
          onPressed: onPressed,
          child: Text(text, style: AppTextTheme.textButtonPrimary),
        ),
      ),
    );
  }
}