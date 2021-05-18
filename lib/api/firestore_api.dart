import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/api/api_keys.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';

class FirestoreApi {
  final FirebaseFirestore _firestore;

  FirestoreApi({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<PointModel> getPoint(String pointId) {
    return _firestore
        .collection(ApiKey.points)
        .doc(pointId)
        .get()
        .asStream()
        .map((snapshot) {
      return PointModel.fromJson(snapshot.data());
    });
  }

  Stream<RouteModel> getRoute(String routeId) {
    return _firestore
        .collection(ApiKey.routes)
        .doc(routeId)
        .get()
        .asStream()
        .map((snapshot) => RouteModel.fromJson(snapshot.data()));
  }

  Stream<List<RouteModel>> getRoutes() {
    return _firestore.collection(ApiKey.routes).snapshots().map((snap) {
      return snap.docs.map((doc) {
        return RouteModel.fromJson(doc.data());
      }).toList();
    });
  }
}
