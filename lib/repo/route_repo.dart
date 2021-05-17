import 'package:travel_app/api/firestore_api.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/utils/dependencies_factory.dart';

class RouteRepo {
  final FirestoreApi _api;

  RouteRepo({FirestoreApi api})
      : _api = api ?? DependenciesFactory.fireStoreApi();

  Stream<PointModel> getPoints(String pointId) => _api.getPoints(pointId);

  Stream<RouteModel> getRoute(String routeId) => _api.getRoute(routeId);
}
