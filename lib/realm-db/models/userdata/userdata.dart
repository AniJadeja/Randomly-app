//realm-db/models/userdata/userdata.dart

import 'package:realm/realm.dart';
part 'userdata.realm.dart';

@RealmModel()
class _UserData {
  @PrimaryKey()
  late String userId;
  late DateTime signUpTimeStamp;
  late String gender;
  late int age;
}