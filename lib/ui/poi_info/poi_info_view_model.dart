import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/location_model.dart';
import 'package:travel_app/models/point_model.dart';

class PoiInfoViewModel {
  final Input input;
  Output output;

  PoiInfoViewModel(this.input) {
    Stream<List<LocationModel>> _openMaps = input.onMapsTapped.flatMap((point) {
      //get current location,
      //add to location list as first item,
      //send to screen
      return null;
    });
    output = Output(_openMaps);
  }
}

class Input {
  final Subject<PointModel> onMapsTapped;

  Input(this.onMapsTapped);
}

class Output {
  final Stream<List<LocationModel>> openMaps;

  Output(this.openMaps);
}
