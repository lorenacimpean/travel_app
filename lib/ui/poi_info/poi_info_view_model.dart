import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/location_model.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/repo/location_repo.dart';
import 'package:travel_app/utils/dependencies_factory.dart';
import 'package:travel_app/utils/ui_model.dart';

class PoiInfoViewModel {
  final Input input;
  final LocationRepo _locationRepo;
  Output output;

  PoiInfoViewModel(this.input, {LocationRepo locationRepo})
      : _locationRepo = locationRepo ?? DependenciesFactory.locationRepo() {
    Stream<UIModel<List<LocationModel>>> _openMaps =
        input.onMapsTapped.flatMap((point) {
      List<LocationModel> locations = [];
      return _locationRepo
          .getLocation()
          .map((location) {
            locations.add(location);
            locations.add(point.location);
            return UIModel.success(locations);
          })
          .startWith(UIModel.loading())
          .onErrorReturnWith((error) => UIModel.error(error));
    });
    output = Output(_openMaps);
  }
}

class Input {
  final Subject<PointModel> onMapsTapped;

  Input(this.onMapsTapped);
}

class Output {
  final Stream<UIModel<List<LocationModel>>> openMaps;

  Output(this.openMaps);
}
