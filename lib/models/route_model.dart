import 'package:travel_app/api/api_keys.dart';
import 'package:travel_app/extensions/list_extensions.dart';
import 'package:travel_app/models/point_model.dart';

class RouteModel {
  final String name;
  final String description;
  final String duration;
  final List<PointModel> points;

  RouteModel({
    this.name,
    this.description,
    this.duration,
    this.points,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return RouteModel(
        name: json[ApiKey.name],
        description: json[ApiKey.description],
        duration: json[ApiKey.duration],
        points: (json[ApiKey.points] as List)
            .toObjectList((json) => PointModel.fromJson(json)));
  }
}
