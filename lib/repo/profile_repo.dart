import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/api/api_keys.dart';
import 'package:travel_app/api/firestore_api.dart';
import 'package:travel_app/models/profile_model.dart';
import 'package:travel_app/utils/dependencies_factory.dart';

class ProfileRepo {
  final FirestoreApi _api;
  final FirebaseAuth _auth;

  ProfileRepo({
    FirestoreApi api,
    FirebaseAuth auth,
  })  : _api = api ?? DependenciesFactory.fireStoreApi(),
        _auth = auth ?? FirebaseAuth.instance;

  Stream<ProfileModel> getUserInfo() {
    String uuid = _auth.currentUser.uid;
    return _api.getUserInfo(uuid).map((json) => ProfileModel.fromJson(json));
  }

  Stream<void> updatePassword(String newPassword) {
    return _auth.currentUser.updatePassword(newPassword).asStream();
  }

  Stream<void> updateEmail(String newEmail) {
    return _auth.currentUser.updateEmail(newEmail).asStream();
  }

  Stream<void> updateProfileData(
      {String firstName, String lastName, String email}) {
    Map<String, dynamic> data = {
      if (firstName != null) ApiKey.firstName: firstName,
      if (lastName != null) ApiKey.lastName: lastName,
      if (email != null) ApiKey.email: email
    };
    String uuid = _auth.currentUser.uid;
    return _api.updateProfileData(uuid, data);
  }

  Stream<void> logout() {
    return _auth.signOut().asStream();
  }
}
