// button_text.dart

import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

class ButtonLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  static ButtonStyle textButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(primaryAccent.withAlpha(0)),
  );

  const ButtonLink({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // The SizedBox is defined here to give the button a consistent, fixed size.
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        style: textButtonStyle,
        onPressed: onPressed,
        child: Container(
          // The padding provides the margin between the text and the underline.
          padding: const EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: textTheme.bodyMedium!.color!,
                width: 1.0, // Adjust the thickness here.
              ),
            ),
          ),
          child: Text(
            text,
            style: textTheme.bodyMedium,
          ),
        )
      ),
    );
  }
}
