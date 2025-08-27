// realm_service.dart

import 'package:realm/realm.dart';
import 'realm_config.dart';
import 'models/task.dart';

class RealmService {
  final Realm realm = RealmConfig.getRealmInstance();

  // CREATE
  void addTask(Task task) {
    realm.write(() {
      realm.add(task);
    });
  }

  // READ
  List<Task> getAllTasks() {
    return realm.all<Task>().toList();
  }

  List<Task> getIncompleteTasks() {
    return realm.all<Task>().query('isComplete == false').toList();
  }

  // UPDATE
  void updateTaskStatus(String taskId, bool isComplete) {
    final task = realm.all<Task>().query('id == \$0', [taskId]).first;
    realm.write(() {
      task.isComplete = isComplete;
    });
  }

  // DELETE
  void deleteTask(String taskId) {
    final task = realm.all<Task>().query('id == \$0', [taskId]).first;
    realm.write(() {
      realm.delete(task);
    });
  }
}
