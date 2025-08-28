// realm-db/models/deviceinfo/device_info.dart
import 'package:realm/realm.dart';

part 'device_info.realm.dart';


@RealmModel()
class _ScreenRes{
  late double height;
  late double width;
}

@RealmModel()
class _DeviceInfo {
  @PrimaryKey()
  late String id;
  late _ScreenRes? screenResolution;
  late String? os;
  late String? fingerprint;
  late String? manufacturer;
  late String? osVersion;
  late String? api;
  late String? identifier;
  late String? model;
  late String? timeZone;
  late String? generatedDeviceId;
  late String? appSetID;
  late String? idfv;
}