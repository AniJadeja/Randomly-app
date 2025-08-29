import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/widgets.dart';

// Class to represent the nested ScreenResolution data.
class ScreenResolution {
  final double height;
  final double width;

  ScreenResolution({required this.height, required this.width});

  factory ScreenResolution.fromJson(Map<String, dynamic> json) {
    return ScreenResolution(
      height: json['Height'] as double,
      width: json['Width'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Height': height,
      'Width': width,
    };
  }
}

// Class to represent the main device information, now called 'Info'.
class Info {
  final ScreenResolution? screenResolution;
  final String os;
  final String? manufacturer;
  final String? osVersion;
  final int? api;
  final String? identifier;
  final String? model;

  Info({
    this.screenResolution,
    required this.os,
    this.manufacturer,
    this.osVersion,
    this.api,
    this.identifier,
    this.model,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      screenResolution: json['ScreenResolution'] != null
          ? ScreenResolution.fromJson(json['ScreenResolution'])
          : null,
      os: json['OS'] as String,
      manufacturer: json['Manufacturer'] as String?,
      osVersion: json['OSVersion'] as String?,
      api: json['API'] as int?,
      identifier: json['Identifier'] as String?,
      model: json['Model'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ScreenResolution': screenResolution?.toJson(),
      'OS': os,
      'Manufacturer': manufacturer,
      'OSVersion': osVersion,
      'API': api,
      'Identifier': identifier,
      'Model': model,
    };
  }
}

// The main class to hold all device-related data.
class DeviceData {
  // Renamed from deviceInfo to metaInfo
  final Info? metaInfo;
  final String? timeZone;


  DeviceData({
    this.metaInfo,
    this.timeZone,

  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      // Updated key from 'DeviceInfo' to 'metaInfo'
      metaInfo: json['DeviceInfo'] != null
          ? Info.fromJson(json['DeviceInfo'])
          : null,
      timeZone: json['TimeZone'] as String?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Updated key from 'DeviceInfo' to 'metaInfo'
      'DeviceInfo': metaInfo?.toJson(),
      'TimeZone': timeZone,

    };
  }
}

class UserDeviceInfo {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  UserDeviceInfo();

  Future<DeviceData?> getDeviceInfo({BuildContext? context}) async {
    try {
      double width = 0;
      double height = 0;

      if (context != null) {
        final mediaQuery = MediaQuery.of(context);
        width = mediaQuery.size.width * mediaQuery.devicePixelRatio;
        height = mediaQuery.size.height * mediaQuery.devicePixelRatio;
      }

      final Map<String, dynamic> deviceInfoMap;


      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        final fingerprint = androidInfo.model ?? '';

        deviceInfoMap = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'Android ${androidInfo.version.release}',
          'Manufacturer': androidInfo.manufacturer ?? '',
          'OSVersion': androidInfo.version.release ?? '',
          'API': androidInfo.version.sdkInt,
          'Identifier': androidInfo.version.incremental ?? '',
          'Model': androidInfo.model ?? '',
        };

      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;

        deviceInfoMap = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'iOS ${iosInfo.systemVersion}',
          'Manufacturer': 'Apple',
          'OSVersion': iosInfo.systemVersion ?? '',
          'API': null,
          'Identifier': iosInfo.utsname.machine,
          'Model': iosInfo.modelName ?? '',
        };

      } else {
        deviceInfoMap = {
          'ScreenResolution': {'Height': height, 'Width': width},
          'OS': 'Unknown',
          'Fingerprint': '',
          'Manufacturer': '',
          'OSVersion': '',
          'API': '',
          'Identifier': '',
          'Model': '',
        };
      }

      String? timeZone;
      try {
        timeZone = await FlutterTimezone.getLocalTimezone();
      } on PlatformException {
        timeZone = 'Failed to get timezone.';
      }


      final finalMap = {
        "DeviceInfo": deviceInfoMap,
        "TimeZone": timeZone,
      };

      return DeviceData.fromJson(finalMap);
    } catch (e) {
      print('Failed to get device info: $e');
      return null;
    }
  }
}
