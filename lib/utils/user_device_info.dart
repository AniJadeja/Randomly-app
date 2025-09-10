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
      height: json['height'] as double,
      width: json['width'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'width': width,
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
      screenResolution: json['screenResolution'] != null
          ? ScreenResolution.fromJson(json['screenResolution'])
          : null,
      os: json['os'] as String,
      manufacturer: json['manufacturer'] as String?,
      osVersion: json['osVersion'] as String?,
      api: json['api'] as int?,
      identifier: json['identifier'] as String?,
      model: json['model'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screenResolution': screenResolution?.toJson(),
      'os': os,
      'manufacturer': manufacturer,
      'osVersion': osVersion,
      'api': api,
      'identifier': identifier,
      'model': model,
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
      metaInfo: json['deviceInfo'] != null
          ? Info.fromJson(json['deviceInfo'])
          : null,
      timeZone: json['timeZone'] as String?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Updated key from 'DeviceInfo' to 'metaInfo'
      'deviceInfo': metaInfo?.toJson(),
      'timeZone': timeZone,

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
          'screenResolution': {'height': height, 'width': width},
          'os': 'Android ${androidInfo.version.release}',
          'manufacturer': androidInfo.manufacturer ?? '',
          'osVersion': androidInfo.version.release ?? '',
          'api': androidInfo.version.sdkInt,
          'identifier': androidInfo.version.incremental ?? '',
          'model': androidInfo.model ?? '',
        };

      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;

        deviceInfoMap = {
          'screenResolution': {'height': height, 'width': width},
          'os': 'ios ${iosInfo.systemVersion}',
          'manufacturer': 'Apple',
          'osVersion': iosInfo.systemVersion ?? '',
          'api': null,
          'identifier': iosInfo.utsname.machine,
          'model': iosInfo.modelName ?? '',
        };

      } else {
        deviceInfoMap = {
          'screenResolution': {'height': height, 'width': width},
          'os': 'Unknown',
          'manufacturer': '',
          'osVersion': '',
          'api': '',
          'identifier': '',
          'model': '',
        };
      }

      String? timeZone;
      try {
        timeZone = await FlutterTimezone.getLocalTimezone();
      } on PlatformException {
        timeZone = 'Failed to get timezone.';
      }


      final finalMap = {
        "deviceInfo": deviceInfoMap,
        "timeZone": timeZone,
      };

      return DeviceData.fromJson(finalMap);
    } catch (e) {
      print('Failed to get device info: $e');
      return null;
    }
  }
}
