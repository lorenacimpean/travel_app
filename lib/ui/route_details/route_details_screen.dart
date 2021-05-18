import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/ui/route_details/route_details_view_model.dart';
import 'package:travel_app/ui/route_details/route_details_widget.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/widget_utils.dart';

class RouteDetailsScreen extends StatefulWidget {
  final RouteModel routeModel;
  final List<PointModel> points;

  RouteDetailsScreen({
    Key key,
    this.routeModel,
    this.points,
  }) : super(key: key);

  @override
  RouteDetailsScreenState createState() => RouteDetailsScreenState();
}

class RouteDetailsScreenState extends BaseState<RouteDetailsScreen> {
  RouteDetailsViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = RouteDetailsViewModel(Input(
      PublishSubject(),
      PublishSubject(),
    ));
    _bindViewModel();
  }

  void _bindViewModel() {
    disposeLater(_vm.output.goBack.listen((_) {
      Navigator.of(context).pop();
    }));
    disposeLater(_vm.output.openMaps.listen((locations) {
      WidgetUtils.launchMapsWithWayPoints(locations);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return RouteDetailsWidget(
        points: widget.points,
        route: widget.routeModel,
        onBackTapped: () => _vm.input.onBackTapped.add(true),
        onOpenMapsTapped: () {
          _vm.input.onMapOpened.add(widget.points);
        });
  }
}
