import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/app_network_image.dart';
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

  static final double _photoSIze = 200;

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
                imgUrl: route.imgUrl,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimen.defaultPadding,
                  horizontal: AppDimen.defaultPadding,
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
              Positioned(
                top: MediaQuery.of(context).size.height / 4 +
                    AppDimen.smallPadding,
                left: MediaQuery.of(context).size.width / 4,
                child: Image(
                  fit: BoxFit.contain,
                  image: AppIcons.play_icon,
                  // fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4 +
                      AppDimen.smallPadding,
                ),
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
              AppStrings.stops,
              style: AppTextStyle.headline2,
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
      height: _photoSIze + AppDimen.largePadding,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: points.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onPointTapped(points[index]),
            child: Padding(
              padding: EdgeInsets.all(AppDimen.smallPadding),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: AppDimen.smallPadding,
                        bottom: AppDimen.smallPadding),
                    width: _photoSIze,
                    child: Text(
                      points[index].name,
                      style: AppTextStyle.headline2.copyWith(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _photoSIze,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppDimen.defaultCornerRadius,
                          ),
                        ),
                        child: AppNetworkImage(points[index]?.imageUrl),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
