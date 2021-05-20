import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/repo/route_repo.dart';
import 'package:travel_app/utils/dependencies_factory.dart';
import 'package:travel_app/utils/ui_model.dart';

class DiscoverViewModel {
  final Input input;
  final RouteRepo _routeRepo;
  Output output;

  DiscoverViewModel(this.input, {RouteRepo routeRepo})
      : _routeRepo = routeRepo ?? DependenciesFactory.routeRepo() {
    Stream<UIModel<List<RouteModel>>> _routes = input.onStart
        .flatMap((_) {
          return _routeRepo.routes.map((routes) => UIModel.success(routes));
        })
        .startWith(UIModel.loading())
        .onErrorReturnWith((error) => UIModel.error(error));

    Stream<RouteInfo> _goToNext = input.onRouteTapped.flatMap((route) {
      return _routeRepo.getPoints(route.pointIds).map((list) {
        return RouteInfo(route, list);
      });
    });
    output = Output(_routes, _goToNext);
  }
}

class Input {
  final Subject<bool> onStart;
  final Subject<RouteModel> onRouteTapped;

  Input(this.onStart, this.onRouteTapped);
}

class Output {
  final Stream<UIModel<List<RouteModel>>> loadRoutes;
  final Stream<RouteInfo> goToNext;

  Output(this.loadRoutes, this.goToNext);
}

class RouteInfo {
  final RouteModel routeModel;
  final List<PointModel> points;

  RouteInfo(this.routeModel, this.points);
}
