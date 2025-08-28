import 'package:randomly/realm-db/models/userdata/userdata.dart';
import 'package:randomly/realm-db/realm_config.dart';
import 'package:randomly/realm-db/realm_service.dart';

class UserDataService {
  late final RealmRepository<UserData> userDataRepository;

  UserDataService() {
    userDataRepository = RealmManager.getInstance(
      schemas: [],
    ).getRepository<UserData>();
  }

  void registerUserData(String userId, String gender, int age) {
    userDataRepository.manageById(
      id: "0",
      manageCallback: (existing) {
        // if user info exists, update it
        if (existing != null) {
          existing.age = age;
          existing.gender = gender;
          existing.userId = userId;
          return existing;
        }
        // else if it does not exist then create it
        else {
          return UserData("0", userId, gender, age);
        }
      },
    );
  }

  fetchUserData() => userDataRepository.get("0");
}
