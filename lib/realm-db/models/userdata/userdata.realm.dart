// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class UserData extends _UserData
    with RealmEntity, RealmObjectBase, RealmObject {
  UserData(String userId, DateTime signUpTimeStamp, String gender, int age) {
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'signUpTimeStamp', signUpTimeStamp);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'age', age);
  }

  UserData._();

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  DateTime get signUpTimeStamp =>
      RealmObjectBase.get<DateTime>(this, 'signUpTimeStamp') as DateTime;
  @override
  set signUpTimeStamp(DateTime value) =>
      RealmObjectBase.set(this, 'signUpTimeStamp', value);

  @override
  String get gender => RealmObjectBase.get<String>(this, 'gender') as String;
  @override
  set gender(String value) => RealmObjectBase.set(this, 'gender', value);

  @override
  int get age => RealmObjectBase.get<int>(this, 'age') as int;
  @override
  set age(int value) => RealmObjectBase.set(this, 'age', value);

  @override
  Stream<RealmObjectChanges<UserData>> get changes =>
      RealmObjectBase.getChanges<UserData>(this);

  @override
  Stream<RealmObjectChanges<UserData>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<UserData>(this, keyPaths);

  @override
  UserData freeze() => RealmObjectBase.freezeObject<UserData>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'userId': userId.toEJson(),
      'signUpTimeStamp': signUpTimeStamp.toEJson(),
      'gender': gender.toEJson(),
      'age': age.toEJson(),
    };
  }

  static EJsonValue _toEJson(UserData value) => value.toEJson();
  static UserData _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'userId': EJsonValue userId,
        'signUpTimeStamp': EJsonValue signUpTimeStamp,
        'gender': EJsonValue gender,
        'age': EJsonValue age,
      } =>
        UserData(
          fromEJson(userId),
          fromEJson(signUpTimeStamp),
          fromEJson(gender),
          fromEJson(age),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(UserData._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, UserData, 'UserData', [
      SchemaProperty('userId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('signUpTimeStamp', RealmPropertyType.timestamp),
      SchemaProperty('gender', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
