import 'package:flutter/material.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/themes/themes.text.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryAccent,
    brightness: Brightness.dark,
    // You can also override the dark theme surface
    // surface: primaryBlack,
    onSurface: primaryWhite,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextTheme.textHeadingDark,
    displayMedium: AppTextTheme.textHeading2Dark,
    bodyLarge: AppTextTheme.textPrimaryDark,
    bodyMedium: AppTextTheme.textSecondaryDark,
    bodySmall: AppTextTheme.textSmallDark,

  ),
);
