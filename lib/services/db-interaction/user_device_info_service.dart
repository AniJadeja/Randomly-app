import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:randomly/realm-db/models/deviceinfo/device_info.dart';
import 'package:randomly/realm-db/realm_config.dart';
import 'package:randomly/utils/user_device_info.dart';

import '../../realm-db/realm_service.dart';

/// A helper function to convert a Realm-managed DeviceInfo object to a Map.
Map<String, dynamic> deviceInfoToJsonMap(DeviceInfo info) {
  return {
    '_id': info.id,
    'ScreenResolution': {
      'Height': info.screenResolution?.height,
      'Width': info.screenResolution?.width,
    },
    'OS': info.os,
    'Fingerprint': info.fingerprint,
    'Manufacturer': info.manufacturer,
    'OSVersion': info.osVersion,
    'API': info.api,
    'Identifier': info.identifier,
    'Model': info.model,
    'TimeZone': info.timeZone,
    'GeneratedDeviceId': info.generatedDeviceId,
    'AppSetID': info.appSetID,
    'IDFV': info.idfv,
  };
}

class UserDeviceInfoService {
  late BuildContext context;
  late final RealmRepository<DeviceInfo> deviceInfoRepository;

  UserDeviceInfoService(this.context) {
    deviceInfoRepository = RealmManager.getInstance(
      schemas: [],
    ).getRepository<DeviceInfo>();
  }

  void registerDeviceInfo() async {
    UserDeviceInfo info = UserDeviceInfo();
    var device = await info.getDeviceInfo(context: context);
    final metaInfo = device!.metaInfo;
    final screenRes = device.metaInfo!.screenResolution;
    deviceInfoRepository.manageById(
      id: "0",
      manageCallback: (existing) {
        // if the info exists, update it
        if (existing != null) {
          existing.screenResolution = ScreenRes(
            screenRes!.height,
            screenRes.width,
          );
          existing.os = metaInfo!.os;
          existing.fingerprint = metaInfo.fingerprint;
          existing.manufacturer = metaInfo.manufacturer;
          existing.osVersion = metaInfo.osVersion;
          existing.api = metaInfo.api.toString();
          existing.identifier = metaInfo.identifier;
          existing.model = metaInfo.model;
          existing.timeZone = device.timeZone;
          existing.generatedDeviceId = device.generatedDeviceId;
          existing.appSetID = device.appSetID;
          existing.idfv = device.idfv;
          return existing;
        }
        // if it doesn't exist, then create it
        else {
          // Create Case
          return DeviceInfo(
            "0",
            screenResolution: ScreenRes(screenRes!.height, screenRes.width),
            os: metaInfo!.os,
            fingerprint: metaInfo.fingerprint,
            manufacturer: metaInfo.manufacturer,
            osVersion: metaInfo.osVersion,
            api: metaInfo.api.toString(),
            identifier: metaInfo.identifier,
            model: metaInfo.model,
            timeZone: device.timeZone,
            generatedDeviceId: device.generatedDeviceId,
            appSetID: device.appSetID,
            idfv: device.idfv,
          );
        }
      },
    );
  }

  /// Fetches the device info from the repository and returns it as a JSON string.
  String? fetchDeviceInfo() {
    final DeviceInfo? info = deviceInfoRepository.get("0");
    if (info != null) {
      // Use the external function to convert the object to a Map.
      final Map<String, dynamic> infoMap = deviceInfoToJsonMap(info);

      // Now encode the Map to a JSON string.
      return jsonEncode(infoMap);
    }
    return null;
  }
}
