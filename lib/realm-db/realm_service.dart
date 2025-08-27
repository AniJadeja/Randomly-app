import 'package:realm/realm.dart';

/// ======================================================================
/// GENERIC REALM REPOSITORY
/// ======================================================================

/// A generic repository class to handle CRUD operations for any RealmModel.
///
/// It uses a generic type T, constrained to be a RealmObject, which allows
/// it to work with any of your Realm-generated model classes (e.g., SessionCurrent, Location).
class RealmRepository<T extends RealmObject> {
  final Realm realm;

  /// Initializes the repository with a Realm instance.
  RealmRepository(this.realm);

  /// --- CREATE Operations ---

  /// Adds a new object to the Realm database.
  void add(T object) {
    realm.write(() {
      realm.add(object);
    });
  }

  /// --- READ Operations ---

  /// Retrieves a single object by its primary key.
  ///
  /// Note: The type of the primary key is 'dynamic' to accommodate different
  /// key types like String, int, or ObjectId.
  T? get(dynamic id) {
    return realm.find<T>(id);
  }

  /// Retrieves a live collection of all objects of type T.
  ///
  /// This collection is live and automatically updates as the data changes.
  RealmResults<T> getAll() {
    return realm.all<T>();
  }

  /// --- UPDATE Operations ---

  /// Updates an existing object in the database.
  ///
  /// The `updateCallback` is a function that takes the object to be updated
  /// and performs the desired modifications. This ensures all updates happen
  /// within a single write transaction.
  void update(T object, void Function(T object) updateCallback) {
    realm.write(() {
      updateCallback(object);
    });
  }

  /// Finds an object by its primary key and updates it within a single call.
  /// This is a more developer-friendly way to update an object by ID.
  ///
  /// Returns the updated object, or null if no object was found with the given ID.
  T? updateById(dynamic id, void Function(T object) updateCallback) {
    // First, get the object by its ID.
    final T? object = get(id);

    // If the object exists, perform the update.
    if (object != null) {
      realm.write(() {
        updateCallback(object);
      });
    }
    return get(id);
  }

  /// --- DELETE Operations ---

  /// Deletes a single object from the database.
  /// Does not return anything
  void delete(T object) {
    realm.write(() {
      realm.delete(object);
    });
  }

  /// Deletes a single object by it's id from the database.
  bool deleteById(dynamic id) {
    final T? object = get(id);

    if (object != null) {
      realm.write(() {
        realm.delete(object);
      });
    }

    if (get(id) != null) {
      return false;
    }
    return true;
  }
}
