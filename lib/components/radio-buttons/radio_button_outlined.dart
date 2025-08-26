import 'package:flutter/material.dart';
import 'package:randomly/themes/themes.text.dart';

import '../../config/config.dart';

class ButtonOutlinedRadio extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const ButtonOutlinedRadio({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.isSelected = false, // External selection state
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width ?? double.infinity;
    final double buttonHeight = height ?? 50.0;
    final theme = Theme.of(context);

    final Color borderColor =
    isSelected ? const Color(0xFF6A8D73) : theme.textTheme.bodySmall!.color!
        .withAlpha(150);
    final Color fillColor =
    isSelected ? const Color(0xFF242627) : theme.scaffoldBackgroundColor;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: fillColor,
              overlayColor: primaryAccent.withAlpha(15) ,
              fixedSize: Size(buttonWidth, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: AppTextTheme.textButtonPrimary),
      ),
    ),);
  }
}
