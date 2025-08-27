import 'package:randomly/realm-db/realm_service.dart';
import 'package:realm/realm.dart';

/// The centralized class to manage Realm initialization and repository creation.
class RealmManager {
  final Realm realm;

  /// Private constructor to ensure a single instance (Singleton pattern).
  RealmManager._(List<SchemaObject> schemas)
      : realm = Realm(Configuration.local(schemas));

  // The singleton instance.
  static RealmManager? _instance;

  /// A static getter to provide a globally accessible, single instance of the manager.
  /// It initializes the instance only once, when it's first accessed.
  static RealmManager getInstance({required List<SchemaObject> schemas}) {
    _instance ??= RealmManager._(schemas);
    return _instance!;
  }

  /// Provides a repository for a specific Realm model type.
  RealmRepository<T> getRepository<T extends RealmObject>() {
    return RealmRepository<T>(realm);
  }

  /// Closes the Realm instance. This should be called when your app is closing.
  void close() {
    realm.close();
  }
}