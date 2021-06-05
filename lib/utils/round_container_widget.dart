import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/ui/widgets/app_network_image.dart';

class RoundContainerWidget extends StatelessWidget {
  final WidgetType widgetType;
  final String imgUrl;

  const RoundContainerWidget({
    Key key,
    @required this.widgetType,
    this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _overlay(context));
  }

  Widget _overlay(BuildContext context) {
    switch (widgetType) {
      case WidgetType.navigation:
        return ClipOval(
          clipper: ColorClipper.navigation(),
          child: Container(
            color: AppColors.primary,
          ),
        );
        break;
      case WidgetType.colorOverlay:
        return ClipOval(
          clipper: ColorClipper.color(),
          child: Container(
            color: AppColors.darkGrey,
          ),
        );
        break;
      case WidgetType.photoOverlay:
        return ClipOval(
          clipper: ColorClipper.photo(),
          child: Container(
            child: AppNetworkImage(
              imgUrl,
              imageHeight: MediaQuery.of(context).size.height / 2 +
                  AppDimen.defaultPadding,
              imageWidth: MediaQuery.of(context).size.width,
            ),
          ),
        );
        break;
      default:
        return null;
    }
  }
}

class ColorClipper extends CustomClipper<Rect> {
  final double offsetDx;
  final double offsetDy;
  final double heightRatio;
  final double weightRatio;

  ColorClipper(
    this.offsetDx,
    this.offsetDy,
    this.heightRatio,
    this.weightRatio,
  );

  factory ColorClipper.navigation() {
    return ColorClipper(0, 50, 0.8, 1.6);
  }

  factory ColorClipper.color() {
    return ColorClipper(200, 0, 0.8, 1.5);
  }

  factory ColorClipper.photo() {
    return ColorClipper(200, 0, 1.3, 1.5);
  }

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
      center: Offset(offsetDx, offsetDy),
      height: size.height * heightRatio,
      width: size.width * weightRatio,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

enum WidgetType { navigation, colorOverlay, photoOverlay }
