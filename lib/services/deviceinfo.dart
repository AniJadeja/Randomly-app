import 'dart:io';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/widgets.dart';
import 'package:randomly/realm-db/models/deviceinfo/device_info.dart';
import 'package:randomly/realm-db/realm_config.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Map<String, dynamic>? deviceInfo;
  String? timeZone;
  String? generatedDeviceId;
  String? appSetID;
  String? idfv;
  String? rawData;

  DeviceInfoService();

  /// Fetch device info and populate the properties
  Future<void> init({BuildContext? context}) async {
    final deviceInfoRepository = RealmManager.getInstance(
      schemas: [DeviceInfo.schema, ScreenRes.schema],
    ).getRepository<DeviceInfo>();

    try {
      double width = 0;
      double height = 0;

      if (context != null) {
        final mediaQuery = MediaQuery.of(context);
        width = mediaQuery.size.width * mediaQuery.devicePixelRatio;
        height = mediaQuery.size.height * mediaQuery.devicePixelRatio;
      }

      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        final fingerprint = androidInfo.model ?? '';

        deviceInfo = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'Android ${androidInfo.version.release}',
          'Fingerprint': fingerprint,
          'Manufacturer': androidInfo.manufacturer ?? '',
          'OSVersion': androidInfo.version.release ?? '',
          'API': androidInfo.version.sdkInt,
          'Identifier': androidInfo.version.incremental ?? '',
          'Model': androidInfo.model ?? '',
        };

        appSetID = androidInfo.id ?? '';
        idfv = null;

        rawData =
        '${androidInfo.model}${androidInfo
            .manufacturer}${fingerprint}${androidInfo.version
            .sdkInt}${androidInfo.version.incremental}';
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;

        idfv = iosInfo.identifierForVendor;
        appSetID = null;

        // --- TODO : Thoroughly test android and IOS devices signups and verify they both have the exact same columns of the device info

        deviceInfo = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'iOS ${iosInfo.systemVersion}',
          'Fingerprint': idfv,
          'Manufacturer': 'Apple',
          'OSVersion': iosInfo.systemVersion ?? '',
          'API': null,
          'Identifier': iosInfo.utsname.machine,
          'Model': iosInfo.modelName ?? '',
        };

        rawData =
        '${iosInfo.name ?? ''}${iosInfo.model ?? ''}${iosInfo.systemVersion ??
            ''}$idfv';
      } else {
        deviceInfo = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'Unknown',
          'Fingerprint': '',
          'Manufacturer': '',
          'OSVersion': '',
          'API': '',
          'Identifier': '',
          'Model': '',
        };
        idfv = null;
        appSetID = null;
        rawData = 'unknown_device';
      }

      // Get timezone
      try {
        timeZone = await FlutterTimezone.getLocalTimezone();
      } on PlatformException {
        timeZone = 'Failed to get timezone.';
      }

      // Generate hashed Canvas-like Device ID
      generatedDeviceId = sha256.convert(utf8.encode(rawData!)).toString();

      deviceInfoRepository.manageById(
        id: "0",
        manageCallback: (existing) {
          // if the info exists, update it
          if (existing != null) {
            existing.screenResolution = ScreenRes(height, width);
            existing.os = deviceInfo!['OS'].toString();
            existing.fingerprint = deviceInfo!['Fingerprint'].toString();
            existing.manufacturer = deviceInfo!['Manufacturer'].toString();
            existing.osVersion = deviceInfo!['OSVersion'].toString();
            existing.api = deviceInfo!['Api'].toString();
            existing.identifier = deviceInfo!['Identifier'].toString();
            existing.model = deviceInfo!['Model'].toString();
            existing.timeZone = timeZone.toString();
            existing.generatedDeviceId = generatedDeviceId.toString();
            existing.appSetID = appSetID;
            existing.idfv = idfv;
            return existing;
          }
          // if it doesn't exist, then create it
          else {
            // Create Case
            return DeviceInfo(
                "0",
                screenResolution: ScreenRes(height, width),
                os: deviceInfo!['OS'].toString(),
                fingerprint: deviceInfo!['Fingerprint'].toString(),
                manufacturer: deviceInfo!['Manufacturer'].toString(),
                osVersion: deviceInfo!['OSVersion'].toString(),
                api: deviceInfo!['API'].toString(),
                identifier: deviceInfo!['Identifier'].toString(),
                model: deviceInfo!['Model'].toString(),
                timeZone: timeZone.toString(),
                generatedDeviceId: generatedDeviceId.toString(),
                appSetID: appSetID.toString(),
                idfv: idfv.toString()
            );
          }
        },
      );
    } catch (e) {
      print('Failed to get device info: $e');
    }
    finally {
      debugPrint(deviceInfoRepository.get("0").toString());
    }
  }

  /// Return device info as JSON
  Map<String, dynamic>? getDeviceInfo() {
    return {
      "DeviceInfo": deviceInfo,
      "TimeZone": timeZone,
      "GeneratedDeviceId": generatedDeviceId,
      "AppSetID": appSetID,
      "IDFV": idfv,
    };
  }
}
