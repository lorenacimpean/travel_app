import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/back_button_widget.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';
import 'package:travel_app/utils/round_container_widget.dart';

class RouteDetailsWidget extends StatelessWidget {
  final RouteModel route;
  final List<PointModel> points;
  final VoidCallback onBackTapped;
  final Function(List<PointModel>) onOpenMapsTapped;
  final Function(PointModel) onPointTapped;

  static final double _listViewSize = 200;

  RouteDetailsWidget({
    Key key,
    this.route,
    this.onBackTapped,
    this.points,
    this.onOpenMapsTapped,
    this.onPointTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              RoundContainerWidget(
                widgetType: WidgetType.photoOverlay,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimen.xlPadding,
                  horizontal: AppDimen.largePadding,
                ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: BackButtonWidget(onBackTapped: onBackTapped)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimen.xxxlPadding),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BlurredButton(text: route?.name ?? ""),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppDimen.xxxlPadding * 2),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AppIcons.play_icon,
                    // fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppDimen.xxxlPadding * 2),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: AppDimen.largePadding,
                        vertical: AppDimen.xxxlPadding,
                      ),
                      child: _screenDetails()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenDetails() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
            child: Text(
              AppStrings.description,
              style: AppTextStyle.headline1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
            child: Text(
              "This is where the route description goes",
              style: AppTextStyle.subtitle2.copyWith(
                fontSize: AppDimen.subtitle1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
            child: Text(
              AppStrings.startPoint,
              style: AppTextStyle.headline2.copyWith(),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
            child: Text(
              "Start point from points ",
              style: AppTextStyle.subtitle2.copyWith(
                fontSize: AppDimen.subtitle1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
            child: Text(
              AppStrings.stops,
              style: AppTextStyle.headline2.copyWith(),
            ),
          ),
          _pointsGallery(),
          Center(
              child: PinkButton(
            text: AppStrings.openMaps,
            onTap: () => onOpenMapsTapped(points),
          )),
        ],
      ),
    );
  }

  Widget _pointsGallery() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
      height: _listViewSize,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: points.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onPointTapped(points[index]),
            child: Padding(
              padding: EdgeInsets.all(AppDimen.smallPadding),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppDimen.defaultCornerRadius,
                  ),
                ),
                child: Image.network(points[index]?.imageUrl ??
                    "https://dummyimage.com/600x400/000/fff"),
              ),
            ),
          );
        },
      ),
    );
  }
}
