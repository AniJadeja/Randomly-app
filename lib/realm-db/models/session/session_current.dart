// session_current.dart

import 'package:realm/realm.dart';
part 'session_current.realm.dart';

@RealmModel()
class _Location {
  late String lat;
  late String long;
  late String locationName;
}

@RealmModel()
class _SessionCurrent {
  @PrimaryKey()
  late String sessionId;
  late DateTime lastSeen;
  late String jwt;
  late String refreshToken;
  late _Location? location;
}