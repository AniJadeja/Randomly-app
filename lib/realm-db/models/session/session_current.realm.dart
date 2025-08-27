// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_current.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Location extends _Location
    with RealmEntity, RealmObjectBase, RealmObject {
  Location(String lat, String long, String locationName) {
    RealmObjectBase.set(this, 'lat', lat);
    RealmObjectBase.set(this, 'long', long);
    RealmObjectBase.set(this, 'locationName', locationName);
  }

  Location._();

  @override
  String get lat => RealmObjectBase.get<String>(this, 'lat') as String;
  @override
  set lat(String value) => RealmObjectBase.set(this, 'lat', value);

  @override
  String get long => RealmObjectBase.get<String>(this, 'long') as String;
  @override
  set long(String value) => RealmObjectBase.set(this, 'long', value);

  @override
  String get locationName =>
      RealmObjectBase.get<String>(this, 'locationName') as String;
  @override
  set locationName(String value) =>
      RealmObjectBase.set(this, 'locationName', value);

  @override
  Stream<RealmObjectChanges<Location>> get changes =>
      RealmObjectBase.getChanges<Location>(this);

  @override
  Stream<RealmObjectChanges<Location>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Location>(this, keyPaths);

  @override
  Location freeze() => RealmObjectBase.freezeObject<Location>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'lat': lat.toEJson(),
      'long': long.toEJson(),
      'locationName': locationName.toEJson(),
    };
  }

  static EJsonValue _toEJson(Location value) => value.toEJson();
  static Location _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'lat': EJsonValue lat,
        'long': EJsonValue long,
        'locationName': EJsonValue locationName,
      } =>
        Location(fromEJson(lat), fromEJson(long), fromEJson(locationName)),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Location._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Location, 'Location', [
      SchemaProperty('lat', RealmPropertyType.string),
      SchemaProperty('long', RealmPropertyType.string),
      SchemaProperty('locationName', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class SessionCurrent extends _SessionCurrent
    with RealmEntity, RealmObjectBase, RealmObject {
  SessionCurrent(
    String sessionId,
    DateTime lastSeen,
    String jwt,
    String refreshToken, {
    Location? location,
  }) {
    RealmObjectBase.set(this, 'sessionId', sessionId);
    RealmObjectBase.set(this, 'lastSeen', lastSeen);
    RealmObjectBase.set(this, 'jwt', jwt);
    RealmObjectBase.set(this, 'refreshToken', refreshToken);
    RealmObjectBase.set(this, 'location', location);
  }

  SessionCurrent._();

  @override
  String get sessionId =>
      RealmObjectBase.get<String>(this, 'sessionId') as String;
  @override
  set sessionId(String value) => RealmObjectBase.set(this, 'sessionId', value);

  @override
  DateTime get lastSeen =>
      RealmObjectBase.get<DateTime>(this, 'lastSeen') as DateTime;
  @override
  set lastSeen(DateTime value) => RealmObjectBase.set(this, 'lastSeen', value);

  @override
  String get jwt => RealmObjectBase.get<String>(this, 'jwt') as String;
  @override
  set jwt(String value) => RealmObjectBase.set(this, 'jwt', value);

  @override
  String get refreshToken =>
      RealmObjectBase.get<String>(this, 'refreshToken') as String;
  @override
  set refreshToken(String value) =>
      RealmObjectBase.set(this, 'refreshToken', value);

  @override
  Location? get location =>
      RealmObjectBase.get<Location>(this, 'location') as Location?;
  @override
  set location(covariant Location? value) =>
      RealmObjectBase.set(this, 'location', value);

  @override
  Stream<RealmObjectChanges<SessionCurrent>> get changes =>
      RealmObjectBase.getChanges<SessionCurrent>(this);

  @override
  Stream<RealmObjectChanges<SessionCurrent>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<SessionCurrent>(this, keyPaths);

  @override
  SessionCurrent freeze() => RealmObjectBase.freezeObject<SessionCurrent>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'sessionId': sessionId.toEJson(),
      'lastSeen': lastSeen.toEJson(),
      'jwt': jwt.toEJson(),
      'refreshToken': refreshToken.toEJson(),
      'location': location.toEJson(),
    };
  }

  static EJsonValue _toEJson(SessionCurrent value) => value.toEJson();
  static SessionCurrent _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'sessionId': EJsonValue sessionId,
        'lastSeen': EJsonValue lastSeen,
        'jwt': EJsonValue jwt,
        'refreshToken': EJsonValue refreshToken,
      } =>
        SessionCurrent(
          fromEJson(sessionId),
          fromEJson(lastSeen),
          fromEJson(jwt),
          fromEJson(refreshToken),
          location: fromEJson(ejson['location']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SessionCurrent._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      SessionCurrent,
      'SessionCurrent',
      [
        SchemaProperty('sessionId', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('lastSeen', RealmPropertyType.timestamp),
        SchemaProperty('jwt', RealmPropertyType.string),
        SchemaProperty('refreshToken', RealmPropertyType.string),
        SchemaProperty(
          'location',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'Location',
        ),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
