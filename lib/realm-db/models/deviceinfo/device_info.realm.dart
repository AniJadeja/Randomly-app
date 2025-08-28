// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class ScreenRes extends _ScreenRes
    with RealmEntity, RealmObjectBase, RealmObject {
  ScreenRes(double height, double width) {
    RealmObjectBase.set(this, 'height', height);
    RealmObjectBase.set(this, 'width', width);
  }

  ScreenRes._();

  @override
  double get height => RealmObjectBase.get<double>(this, 'height') as double;
  @override
  set height(double value) => RealmObjectBase.set(this, 'height', value);

  @override
  double get width => RealmObjectBase.get<double>(this, 'width') as double;
  @override
  set width(double value) => RealmObjectBase.set(this, 'width', value);

  @override
  Stream<RealmObjectChanges<ScreenRes>> get changes =>
      RealmObjectBase.getChanges<ScreenRes>(this);

  @override
  Stream<RealmObjectChanges<ScreenRes>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ScreenRes>(this, keyPaths);

  @override
  ScreenRes freeze() => RealmObjectBase.freezeObject<ScreenRes>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'height': height.toEJson(),
      'width': width.toEJson(),
    };
  }

  static EJsonValue _toEJson(ScreenRes value) => value.toEJson();
  static ScreenRes _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'height': EJsonValue height, 'width': EJsonValue width} => ScreenRes(
        fromEJson(height),
        fromEJson(width),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ScreenRes._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, ScreenRes, 'ScreenRes', [
      SchemaProperty('height', RealmPropertyType.double),
      SchemaProperty('width', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class DeviceInfo extends _DeviceInfo
    with RealmEntity, RealmObjectBase, RealmObject {
  DeviceInfo(
    String id, {
    ScreenRes? screenResolution,
    String? os,
    String? fingerprint,
    String? manufacturer,
    String? osVersion,
    String? api,
    String? identifier,
    String? model,
    String? timeZone,
    String? generatedDeviceId,
    String? appSetID,
    String? idfv,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'screenResolution', screenResolution);
    RealmObjectBase.set(this, 'os', os);
    RealmObjectBase.set(this, 'fingerprint', fingerprint);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'osVersion', osVersion);
    RealmObjectBase.set(this, 'api', api);
    RealmObjectBase.set(this, 'identifier', identifier);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'timeZone', timeZone);
    RealmObjectBase.set(this, 'generatedDeviceId', generatedDeviceId);
    RealmObjectBase.set(this, 'appSetID', appSetID);
    RealmObjectBase.set(this, 'idfv', idfv);
  }

  DeviceInfo._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  ScreenRes? get screenResolution =>
      RealmObjectBase.get<ScreenRes>(this, 'screenResolution') as ScreenRes?;
  @override
  set screenResolution(covariant ScreenRes? value) =>
      RealmObjectBase.set(this, 'screenResolution', value);

  @override
  String? get os => RealmObjectBase.get<String>(this, 'os') as String?;
  @override
  set os(String? value) => RealmObjectBase.set(this, 'os', value);

  @override
  String? get fingerprint =>
      RealmObjectBase.get<String>(this, 'fingerprint') as String?;
  @override
  set fingerprint(String? value) =>
      RealmObjectBase.set(this, 'fingerprint', value);

  @override
  String? get manufacturer =>
      RealmObjectBase.get<String>(this, 'manufacturer') as String?;
  @override
  set manufacturer(String? value) =>
      RealmObjectBase.set(this, 'manufacturer', value);

  @override
  String? get osVersion =>
      RealmObjectBase.get<String>(this, 'osVersion') as String?;
  @override
  set osVersion(String? value) => RealmObjectBase.set(this, 'osVersion', value);

  @override
  String? get api => RealmObjectBase.get<String>(this, 'api') as String?;
  @override
  set api(String? value) => RealmObjectBase.set(this, 'api', value);

  @override
  String? get identifier =>
      RealmObjectBase.get<String>(this, 'identifier') as String?;
  @override
  set identifier(String? value) =>
      RealmObjectBase.set(this, 'identifier', value);

  @override
  String? get model => RealmObjectBase.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObjectBase.set(this, 'model', value);

  @override
  String? get timeZone =>
      RealmObjectBase.get<String>(this, 'timeZone') as String?;
  @override
  set timeZone(String? value) => RealmObjectBase.set(this, 'timeZone', value);

  @override
  String? get generatedDeviceId =>
      RealmObjectBase.get<String>(this, 'generatedDeviceId') as String?;
  @override
  set generatedDeviceId(String? value) =>
      RealmObjectBase.set(this, 'generatedDeviceId', value);

  @override
  String? get appSetID =>
      RealmObjectBase.get<String>(this, 'appSetID') as String?;
  @override
  set appSetID(String? value) => RealmObjectBase.set(this, 'appSetID', value);

  @override
  String? get idfv => RealmObjectBase.get<String>(this, 'idfv') as String?;
  @override
  set idfv(String? value) => RealmObjectBase.set(this, 'idfv', value);

  @override
  Stream<RealmObjectChanges<DeviceInfo>> get changes =>
      RealmObjectBase.getChanges<DeviceInfo>(this);

  @override
  Stream<RealmObjectChanges<DeviceInfo>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<DeviceInfo>(this, keyPaths);

  @override
  DeviceInfo freeze() => RealmObjectBase.freezeObject<DeviceInfo>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'screenResolution': screenResolution.toEJson(),
      'os': os.toEJson(),
      'fingerprint': fingerprint.toEJson(),
      'manufacturer': manufacturer.toEJson(),
      'osVersion': osVersion.toEJson(),
      'api': api.toEJson(),
      'identifier': identifier.toEJson(),
      'model': model.toEJson(),
      'timeZone': timeZone.toEJson(),
      'generatedDeviceId': generatedDeviceId.toEJson(),
      'appSetID': appSetID.toEJson(),
      'idfv': idfv.toEJson(),
    };
  }

  static EJsonValue _toEJson(DeviceInfo value) => value.toEJson();
  static DeviceInfo _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id} => DeviceInfo(
        fromEJson(id),
        screenResolution: fromEJson(ejson['screenResolution']),
        os: fromEJson(ejson['os']),
        fingerprint: fromEJson(ejson['fingerprint']),
        manufacturer: fromEJson(ejson['manufacturer']),
        osVersion: fromEJson(ejson['osVersion']),
        api: fromEJson(ejson['api']),
        identifier: fromEJson(ejson['identifier']),
        model: fromEJson(ejson['model']),
        timeZone: fromEJson(ejson['timeZone']),
        generatedDeviceId: fromEJson(ejson['generatedDeviceId']),
        appSetID: fromEJson(ejson['appSetID']),
        idfv: fromEJson(ejson['idfv']),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(DeviceInfo._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      DeviceInfo,
      'DeviceInfo',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty(
          'screenResolution',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'ScreenRes',
        ),
        SchemaProperty('os', RealmPropertyType.string, optional: true),
        SchemaProperty('fingerprint', RealmPropertyType.string, optional: true),
        SchemaProperty(
          'manufacturer',
          RealmPropertyType.string,
          optional: true,
        ),
        SchemaProperty('osVersion', RealmPropertyType.string, optional: true),
        SchemaProperty('api', RealmPropertyType.string, optional: true),
        SchemaProperty('identifier', RealmPropertyType.string, optional: true),
        SchemaProperty('model', RealmPropertyType.string, optional: true),
        SchemaProperty('timeZone', RealmPropertyType.string, optional: true),
        SchemaProperty(
          'generatedDeviceId',
          RealmPropertyType.string,
          optional: true,
        ),
        SchemaProperty('appSetID', RealmPropertyType.string, optional: true),
        SchemaProperty('idfv', RealmPropertyType.string, optional: true),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
