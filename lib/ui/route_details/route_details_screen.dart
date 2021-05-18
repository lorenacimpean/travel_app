import 'package:flutter/cupertino.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/ui/route_details/route_details_widget.dart';

class RouteDetails extends StatelessWidget {
  final RouteModel routeModel;
  final List<PointModel> points;

  const RouteDetails({Key key, this.routeModel, this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RouteDetailsWidget();
  }
}
