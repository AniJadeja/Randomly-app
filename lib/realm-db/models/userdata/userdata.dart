//models/location_history

import 'package:realm/realm.dart';

class _UserData {
  @PrimaryKey()
  late String userId;
  late DateTime signUpTimeStamp;
  late String gender;
  late int age;
  late Map<String, dynamic> deviceInfo;
}