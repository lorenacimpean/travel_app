import 'package:travel_app/api/api_keys.dart';
import 'package:travel_app/models/location_model.dart';

class PointModel {
  final String name;
  final String description;
  final String duration;
  final LocationModel location;
  final String imageUrl;
  String address;

  PointModel({
    this.name,
    this.description,
    this.duration,
    this.location,
    this.imageUrl,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return PointModel(
      name: json[ApiKey.name],
      description: json[ApiKey.description],
      duration: json[ApiKey.duration],
      location: LocationModel.fromGeopoint(json[ApiKey.location]),
      imageUrl: json[ApiKey.url],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          duration == other.duration &&
          location == other.location &&
          imageUrl == other.imageUrl &&
          address == other.address;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      duration.hashCode ^
      location.hashCode ^
      imageUrl.hashCode ^
      address.hashCode;
}
