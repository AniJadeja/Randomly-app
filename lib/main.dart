import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:randomly/pages/signup/age_screen.dart';
import 'package:randomly/pages/signup/gender_screen.dart';
import 'package:randomly/pages/signup/intro_screen.dart';
import 'package:randomly/pages/signup/start_screen.dart';
import 'package:randomly/themes/theme.dark.dart';
import 'package:randomly/themes/theme.light.dart';
import 'package:randomly/themes/themes.text.dart';
import 'config/config.dart';
import 'pages/home_screen.dart';

void main() {
  debugPaintSizeEnabled = false; // This is the key line
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      darkTheme: darkTheme,

      home: AgePickerScreen(),
    );
  }
}
