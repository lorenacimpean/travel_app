import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/location_model.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/repo/location_repo.dart';
import 'package:travel_app/utils/dependencies_factory.dart';
import 'package:travel_app/utils/ui_model.dart';

class RouteDetailsViewModel {
  final Input input;
  final LocationRepo _locationRepo;
  Output output;

  RouteDetailsViewModel(
    this.input, {
    LocationRepo locationRepo,
  }) : _locationRepo = locationRepo ?? DependenciesFactory.locationRepo() {
    Stream<bool> _goBack = input.onBackTapped;

    Stream<UIModel<List<LocationModel>>> _openMaps =
        input.onMapOpened.flatMap((points) {
      List<LocationModel> locations = [];
      return _locationRepo
          .getLocation()
          .map((location) {
            locations.add(location);
            points.forEach((point) {
              locations.add(point.location);
            });
            return UIModel.success(locations);
          })
          .startWith(UIModel.loading())
          .onErrorReturnWith((error) => UIModel.error(error));
    });

    Stream<PointModel> _openPoiInfo = input.onPointTapped.flatMap((point) {
      return _locationRepo
          .getAddressFromCoordinates(point.location)
          .map((address) {
        point.address = address;
        return point;
      });
    });

    output = Output(
      _goBack,
      _openMaps,
      _openPoiInfo,
    );
  }
}

class Input {
  final Subject<bool> onBackTapped;
  final Subject<List<PointModel>> onMapOpened;
  final Subject<PointModel> onPointTapped;

  Input(
    this.onBackTapped,
    this.onMapOpened,
    this.onPointTapped,
  );
}

class Output {
  final Stream<bool> goBack;
  final Stream<UIModel<List<LocationModel>>> openMaps;
  final Stream<PointModel> openPoiInfo;

  Output(
    this.goBack,
    this.openMaps,
    this.openPoiInfo,
  );
}
