import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:randomly/pages/signup/start_screen.dart';
import 'package:randomly/realm-db/models/session/session_current.dart';
import 'package:randomly/realm-db/realm_config.dart';
import 'package:randomly/services/deviceinfo.dart';
import 'package:randomly/services/location.dart';
import 'package:randomly/themes/theme.dark.dart';
import 'package:randomly/themes/theme.light.dart';
import 'package:realm/realm.dart';
import 'config/config.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

void main() {
  debugPaintSizeEnabled = false; // This is the key line
  runApp(const MyApp());

  final sessionRepository = RealmManager.getInstance(
    schemas: [SessionCurrent.schema, Location.schema],
  ).getRepository<SessionCurrent>();

  final random = Random();
  final randomNumber = random.nextInt(100000);
  final String newSessionId = randomNumber.toString();
  final location = Location("lat", "long", "locationName");

  final session = SessionCurrent(
    newSessionId,
    DateTime.now(),
    "jwt",
    "refreshToken",
    location: location,
  );

  // add session
  sessionRepository.add(session);

  final sessions = sessionRepository.getAll();
  print("Sessions : ");
  sessions.forEach((session) {
    print(session.toEJson());
  });
  //
  // // get session by id
  // final SessionCurrent? sessionWithId = sessionRepository.get("id");
  // print("Session with id : ${sessionWithId.toEJson()}");
  //
  // // update sesion by id
  // final updated = sessionRepository.updateById("id", (s) {
  //   s.jwt = "new-jwt";
  //   s.refreshToken = "new-ref";
  // });
  // print("Updated obj jwt :  ${updated.toEJson()}");
  //
  // // --- Delete ---
  // print('\nDeleting the session...');
  // print('Is session deleted? ${sessionRepository.deleteById(newSessionId)}');

  printServices();
  
}

void printServices () async {

  DeviceInfoService service = DeviceInfoService();
  print("Device Info : ${await service.getDeviceInfo()}");

  LocationService locationService = LocationService();
  print("Location : ${await locationService.getGPSLocation()}");
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

      home: StartScreen(),
    );
  }
}
