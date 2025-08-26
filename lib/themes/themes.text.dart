import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';

class AppTextTheme {
  AppTextTheme();

  // Define a single base style that all others will inherit from.
  static const String _fontFamily = "InriaSans";

  static const double _heading1Size = 32;
  static const double _heading2Size = 24;

  static const double bodyLargeTextSize = 16;
  static const double _bodyMediumTextSize = 14;
  static const double _bodySmallTextSize = 10;

  static final TextStyle _baseTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    letterSpacing: 1.0,
  );

  // --- Theme-agnostic Text Styles ---
  // Styles that don't change between dark and light themes.

  static final TextStyle textButtonPrimary = _baseTextStyle.copyWith(
    fontSize: bodyLargeTextSize,
    color: primaryWhite,
  );

  static final TextStyle verticalText = _baseTextStyle.copyWith(
    fontSize: bodyLargeTextSize,
    color: secondaryOnDark, // This one is dependent on the dark theme
    letterSpacing: 2.0,
  );

  // --- Base Styles for each theme ---
  // Define a base style for each theme to handle color and weight variations.

  static final TextStyle _baseDark = _baseTextStyle.copyWith(
    color: secondaryOnDark,
  );

  static final TextStyle _baseLight = _baseTextStyle.copyWith(
    color: secondaryOnLight,
  );

  // --- Dark Theme Text Styles ---

  static final TextStyle textHeadingDark = _baseDark.copyWith(
    fontSize: _heading1Size,
    fontWeight: FontWeight.bold,
    color: primaryWhite,
    letterSpacing: 2.0,
  );

  static final TextStyle textButtonOutlinedDark = _baseDark.copyWith(
    fontSize: bodyLargeTextSize,
  );

  static final TextStyle textHeading2Dark = textHeadingDark.copyWith(
    fontSize: _heading2Size,
  );

  static final TextStyle textPrimaryDark = _baseDark.copyWith(
    fontSize: bodyLargeTextSize,
  );

  static final TextStyle textSecondaryDark = _baseDark.copyWith(
    fontSize: _bodyMediumTextSize,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle textSmallDark = _baseDark.copyWith(
    fontSize: _bodySmallTextSize,
    fontWeight: FontWeight.w400,
  );


  // --- Light Theme Text Styles ---

  static final TextStyle textHeadingLight = _baseLight.copyWith(
    fontSize: _heading1Size,
    fontWeight: FontWeight.bold,
    color: primaryBlack,
  );


  static final TextStyle textButtonOutlinedLight = _baseLight.copyWith(
    fontSize: bodyLargeTextSize,
  );

  static final TextStyle textHeading2Light = textHeadingLight.copyWith(
    fontSize: _heading2Size,
  );

  static final TextStyle textPrimaryLight = _baseLight.copyWith(
    fontSize: bodyLargeTextSize,
  );

  static final TextStyle textSecondaryLight = _baseLight.copyWith(
    fontSize: _bodyMediumTextSize,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle textSmallLight = _baseLight.copyWith(
    fontSize: _bodySmallTextSize,
    fontWeight: FontWeight.w400,
  );
}
