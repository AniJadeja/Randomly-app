import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:randomly/pages/signup/start_screen.dart';
import 'package:randomly/realm-db/models/deviceinfo/device_info.dart';
import 'package:randomly/realm-db/models/session/session_current.dart';
import 'package:randomly/realm-db/models/userdata/userdata.dart';
import 'package:randomly/realm-db/realm_config.dart';
import 'package:randomly/themes/theme.dark.dart';
import 'package:randomly/themes/theme.light.dart';
import 'config/config.dart';

// 1. Make the main function asynchronous
Future<void> main() async {
  // 2. Ensure Flutter is initialized before anything else
  WidgetsFlutterBinding.ensureInitialized();

  debugPaintSizeEnabled = false;

  // 3. Await the initialization of your RealmManager singleton
  // This will ensure it's fully configured before the app starts
  RealmManager.getInstance(
    schemas: [
      SessionCurrent.schema,
      Location.schema,
      UserData.schema,
      DeviceInfo.schema,
      ScreenRes.schema,
    ],
  );

  // 4. Now, run the app. It's safe to do this because Realm is ready.
  runApp(const Randomly());
}


class Randomly extends StatelessWidget {
  const Randomly({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      darkTheme: darkTheme,

      home: StartScreen(),
    );
  }
}
