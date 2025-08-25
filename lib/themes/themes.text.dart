import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';

class AppTextTheme {
  AppTextTheme();

  // Theme agnostic Text Styles

  static TextStyle textButtonPrimary = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryWhite,
    letterSpacing: 1,
  );

  static TextStyle verticalText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 17,
    color: secondaryOnDark,
    letterSpacing: 2,
    fontFamily: "InriaSans",
  );

  // Dark Theme Text Styles

  static TextStyle textHeadingDark = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primaryWhite,
    letterSpacing: 2,
  );

  static TextStyle textPrimaryDark = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryOnDark,
  );

  static TextStyle textSecondaryDark = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: secondaryOnDark,
  );

  static TextStyle textSmallDark = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: secondaryOnDark,
  );

  // Light Theme Text Styles

  static TextStyle textHeadingLight = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryBlack,
  );

  static TextStyle textPrimaryLight = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryOnLight,
  );

  static TextStyle textSecondaryLight = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: secondaryOnLight,
  );

  static TextStyle textSmallLight = TextStyle(
    fontFamily: "InriaSans",
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: secondaryOnLight,
  );
}
