import 'package:rxdart/rxdart.dart';
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
    output = Output(_routes);
  }
}

class Input {
  final Subject<bool> onStart;

  Input(this.onStart);
}

class Output {
  final Stream<UIModel<List<RouteModel>>> loadRoutes;

  Output(this.loadRoutes);
}
