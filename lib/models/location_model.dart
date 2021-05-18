import 'package:travel_app/api/api_keys.dart';

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return LocationModel(
      latitude: json[ApiKey.latitude],
      longitude: json[ApiKey.longitude],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.latitude: latitude,
      ApiKey.longitude: longitude,
    };
  }

  String get string {
    return "$latitude,$longitude";
  }
}
