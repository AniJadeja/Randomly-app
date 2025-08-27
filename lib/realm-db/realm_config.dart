// realm_config.dart

import 'package:realm/realm.dart';
import 'models/task.dart';

class RealmConfig {
  static Realm getRealmInstance() {
    final config = Configuration.local([Task.schema]);
    return Realm(config);
  }
}
