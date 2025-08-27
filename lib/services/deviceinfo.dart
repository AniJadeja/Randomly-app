import 'dart:io';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/widgets.dart';

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
          'identifier': androidInfo.version.incremental ?? '',
          'Model': androidInfo.model ?? '',
        };

        appSetID = androidInfo.id ?? '';
        idfv = null;

        rawData =
        '${androidInfo.model}${androidInfo.manufacturer}${fingerprint}${androidInfo.version.sdkInt}${androidInfo.version.incremental}';
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
          'identifier': iosInfo.utsname.machine,
          'Model': iosInfo.modelName ?? '',
        };

        rawData =
        '${iosInfo.name ?? ''}${iosInfo.model ?? ''}${iosInfo.systemVersion ?? ''}$idfv';
      } else {
        deviceInfo = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'Unknown',
          'Fingerprint': '',
          'Manufacturer': '',
          'OSVersion': '',
          'API': '',
          'identifier': '',
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
    } catch (e) {
      print('Failed to get device info: $e');
    }
  }

  /// Return device info as JSON
  Map<String, dynamic>? getDeviceInfo() {
    return {
      "DeviceInfo": deviceInfo,
      "TimeZone" : timeZone,
      "GeneratedDeviceId" : generatedDeviceId,
      "AppSetID" : appSetID,
      "IDFV" : idfv
    };
  }
}
