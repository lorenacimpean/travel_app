import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:travel_app/models/location_model.dart';

class LocationRepo {
  final loc.Location _location;

  LocationRepo({loc.Location location})
      : _location = location ?? loc.Location();

  Stream<loc.PermissionStatus> checkPermission() =>
      _location.hasPermission().asStream().map((result) {
        if (result != loc.PermissionStatus.granted) {
          _location.requestPermission();
        }
        return result;
      });

  Stream<LocationModel> getLocation() => _location.getLocation().asStream().map(
        (data) => LocationModel(
          latitude: data.latitude,
          longitude: data.longitude,
        ),
      );

  Stream<String> getAddressFromCoordinates(
    LocationModel location,
  ) {
    return placemarkFromCoordinates(location.latitude, location.longitude)
        .asStream()
        .map((placeMark) {
      String streetAddress =
          "No. ${placeMark.first.subThoroughfare}, ${placeMark.first.thoroughfare}, ${placeMark.first.locality}";
      return streetAddress;
    });
  }
}
