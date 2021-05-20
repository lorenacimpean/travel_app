import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/ui/poi_info/poi_info_screen.dart';
import 'package:travel_app/ui/route_details/route_details_view_model.dart';
import 'package:travel_app/ui/route_details/route_details_widget.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/ui_model.dart';
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
      PublishSubject(),
    ));
    _bindViewModel();
  }

  void _bindViewModel() {
    disposeLater(_vm.output.goBack.listen((_) {
      Navigator.of(context).pop();
    }));
    disposeLater(_vm.output.openMaps.listen((response) {
      setState(() {
        switch (response.state) {
          case OperationState.loading:
            // TODO: show Loading
            break;
          case OperationState.error:
            displayErrorModal(context, response.error.toString());
            break;
          case OperationState.ok:
            WidgetUtils.launchMapsWithWayPoints(response.data);
            break;
        }
      });
    }));
    disposeLater(_vm.output.openPoiInfo.listen((point) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PoiInfoScreen(
                    point: point,
                  )));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return RouteDetailsWidget(
      points: widget.points,
      route: widget.routeModel,
      onBackTapped: () => _vm.input.onBackTapped.add(true),
      onOpenMapsTapped: (points) {
        _vm.input.onMapOpened.add(points);
      },
      onPointTapped: (point) {
        _vm.input.onPointTapped.add(point);
      },
    );
  }
}
