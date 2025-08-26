import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryAccent,
    brightness: Brightness.light,
    // Override the calculated surface color
    surface: primaryWhite,
    onSurface: primaryBlack,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextTheme.textHeadingLight,
    displayMedium: AppTextTheme.textHeading2Light,
    bodyLarge: AppTextTheme.textPrimaryLight,
    bodyMedium: AppTextTheme.textSecondaryLight,
    bodySmall: AppTextTheme.textSmallLight,
  ),
);
