import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_app/models/location_model.dart';

class LocationRepo {
  Stream<LocationModel> getLocation() {
    return Geolocator.getLastKnownPosition().asStream().map(
          (data) => LocationModel(
            latitude: data.latitude,
            longitude: data.longitude,
          ),
        );
  }

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
