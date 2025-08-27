import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:randomly/pages/signup/age_screen.dart';
import 'package:randomly/pages/signup/gender_screen.dart';
import 'package:randomly/pages/signup/intro_screen.dart';
import 'package:randomly/pages/signup/start_screen.dart';
import 'package:randomly/realm-db/models/task.dart';
import 'package:randomly/realm-db/realm_service.dart';
import 'package:randomly/themes/theme.dark.dart';
import 'package:randomly/themes/theme.light.dart';
import 'package:randomly/themes/themes.text.dart';
import 'package:realm/realm.dart';
import 'config/config.dart';
import 'pages/home_screen.dart';

void main() {
  debugPaintSizeEnabled = false; // This is the key line
  runApp(const MyApp());

  final realmService = RealmService();

  // CREATE
  final newTask = Task(ObjectId().toString(), 'Learn Flutter');
  realmService.addTask(newTask);

  // READ
  // final allTasks = realmService.getAllTasks().toString();


  // UPDATE
  realmService.updateTaskStatus(newTask.id, true);

  // DELETE
  // realmService.deleteTask(newTask.id);

  final allTasks = realmService.getAllTasks();
  allTasks.forEach((task) {
    final extendedTask = TaskExtended(task.id, task.name);
    print(extendedTask);
  });
}

class TaskExtended extends Task {
  TaskExtended(String id, String name)
      : super(id, name);

  @override
  String toString() {
    return 'Task{id: $id, name: $name';
  }
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
