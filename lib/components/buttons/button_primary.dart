// button_primary.dart

import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? cornerRadius;

  const ButtonPrimary({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.cornerRadius
  });

  @override
  Widget build(BuildContext context) {
    // Determine the button's final width. Defaults to full width (double.infinity) if null.
    final double buttonWidth = width ?? double.infinity;
    // Determine the button's final height. Defaults to 50.0 if null.
    final double buttonHeight = height ?? 50.0;

    final double radius = cornerRadius ?? 40.0;

    // Note: MaterialButton doesn't use ButtonStyle directly.
    // We'll apply the properties individually.

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      // Set height on SizedBox or directly on MaterialButton if you prefer
      child: MaterialButton(
        color: primaryAccent,
        // Use 'color' for background
        elevation: 1.0,

        splashColor: primaryAccent.withAlpha(5),
        // 'overlayColor' equivalent for tap feedback
        // highlightElevation: 5.0,
        // Or adjust as needed, 'shadowColor' is a bit different
        // For shadowColor, MaterialButton's shadow is primarily controlled by elevation.
        // You might need to wrap it in a Material widget with a specific shadowColor
        // if the default shadow behavior isn't what you need.
        minWidth: buttonWidth,
        // Ensure the button tries to fill the width
        height: buttonHeight,
        // Set height directly
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius), // Adjust the radius as needed
          // You can also add a border side if you want an outline
          // side: BorderSide(color: Colors.red)
        ),
        child: Text(text, style: AppTextTheme.textButtonPrimary)
      ),
    );
  }
}
