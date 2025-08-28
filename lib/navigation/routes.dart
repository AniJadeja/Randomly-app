import 'package:flutter/material.dart';
import 'package:randomly/pages/my_home_screen.dart';
import 'package:randomly/pages/signup/age_screen.dart';
import 'package:randomly/pages/signup/gender_screen.dart';
import 'package:randomly/pages/signup/intro_screen.dart';
import 'package:randomly/pages/signup/start_screen.dart';
import 'package:randomly/config/strings/routes.dart';

final Map<String, WidgetBuilder> routes = {
  startScreenRoute: (context) => const StartScreen(),
  introScreenRoute: (context) => const IntroScreen(),
  genderScreenRoute: (context) => const GenderPickerScreen(),
  ageScreenRoute: (context) => const AgePickerScreen(),
  homeScreenRoute: (context) => const MyHomePage(title: "Hello Home"),
};
