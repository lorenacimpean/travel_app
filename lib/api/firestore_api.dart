import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/api/api_keys.dart';

class FirestoreApi {
  final FirebaseFirestore _firestore;

  FirestoreApi({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getPoints(List<String> pointIds) {
    return _firestore
        .collection(ApiKey.points)
        .where(FieldPath.documentId, whereIn: pointIds)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<Map<String, dynamic>> getPoint(String pointId) {
    return _firestore
        .collection(ApiKey.points)
        .doc(pointId)
        .get()
        .asStream()
        .map((snapshot) => snapshot.data());
  }

  Stream<Map<String, dynamic>> getRoute(String routeId) {
    return _firestore
        .collection(ApiKey.routes)
        .doc(routeId)
        .get()
        .asStream()
        .map((snapshot) => snapshot.data());
  }

  Stream<List<Map<String, dynamic>>> getRoutes() {
    return _firestore.collection(ApiKey.routes).snapshots().map((snap) {
      return snap.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<Map<String, dynamic>> getUserInfo(String uuid) {
    return _firestore
        .collection(ApiKey.users)
        .doc(uuid)
        .get()
        .asStream()
        .map((snap) => snap.data());
  }

  Stream<void> updateProfileData(
      String uuid, Map<String, dynamic> profileData) {
    return _firestore
        .collection(ApiKey.users)
        .doc(uuid)
        .set(profileData)
        .asStream();
  }
}
