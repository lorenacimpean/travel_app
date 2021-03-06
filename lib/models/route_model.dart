import 'package:travel_app/api/api_keys.dart';

class RouteModel {
  final String name;
  final String description;
  final String duration;
  final List<dynamic> pointIds;
  final String imgUrl;

  RouteModel({
    this.name,
    this.description,
    this.duration,
    this.pointIds,
    this.imgUrl,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return RouteModel(
      name: json[ApiKey.name],
      description: json[ApiKey.description],
      duration: json[ApiKey.duration],
      pointIds: json[ApiKey.points],
      imgUrl: json[ApiKey.imgUrl],
    );
  }
}
