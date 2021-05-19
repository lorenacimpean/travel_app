import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/location_model.dart';
import 'package:travel_app/models/point_model.dart';

class RouteDetailsViewModel {
  final Input input;
  Output output;

  RouteDetailsViewModel(this.input) {
    Stream<bool> _goBack = input.onBackTapped;
    Stream<List<LocationModel>> _openMaps = input.onMapOpened.map((points) {
      List<LocationModel> locations = [];
      points.forEach((point) {
        locations.add(point.location);
      });
      return locations;
    });
    Stream<PointModel> _openPoiInfo = input.onPointTapped;
    output = Output(_goBack, _openMaps, _openPoiInfo);
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
  final Stream<List<LocationModel>> openMaps;
  final Stream<PointModel> openPoiInfo;

  Output(this.goBack, this.openMaps, this.openPoiInfo);
}
