import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory LocationModel.fromGeopoint(GeoPoint geoPoint) {
    return LocationModel(
      latitude: geoPoint.latitude,
      longitude: geoPoint.longitude,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModel &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
