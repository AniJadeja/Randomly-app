//models/task.dart

import 'package:realm/realm.dart';
part 'task.realm.dart';

@RealmModel()
class _Task {
  @PrimaryKey()
  late String id;

  late String name;
  bool isComplete = false;
}