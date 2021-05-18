import 'package:travel_app/api/firestore_api.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/utils/dependencies_factory.dart';

class RouteRepo {
  final FirestoreApi _api;

  RouteRepo({FirestoreApi api})
      : _api = api ?? DependenciesFactory.fireStoreApi();

  Stream<PointModel> getPoint(String pointId) {
    return _api.getPoint(pointId).map((json) => PointModel.fromJson(json));
  }

  Stream<List<PointModel>> getPoints(List<dynamic> pointIds) {
    List<String> stringList = pointIds.map((e) => e.toString()).toList();
    return _api.getPoints(stringList).map((points) =>
        points.map((pointJson) => PointModel.fromJson(pointJson)).toList());
  }

  Stream<RouteModel> getRoute(String routeId) {
    return _api.getRoute(routeId).map((json) => RouteModel.fromJson(json));
  }

  Stream<List<RouteModel>> get routes => _api.getRoutes().map(
      (routes) => routes.map((json) => RouteModel.fromJson(json)).toList());
}
