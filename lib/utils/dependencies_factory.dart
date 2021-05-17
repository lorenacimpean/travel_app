import 'package:travel_app/api/firestore_api.dart';
import 'package:travel_app/repo/auth_repo.dart';
import 'package:travel_app/repo/route_repo.dart';

class DependenciesFactory {
  static fireStoreApi() => FirestoreApi();

  static authRepo() => AuthRepo();

  static routeRepo() => RouteRepo();

  static pointRepo() => RouteRepo();
}