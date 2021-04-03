import 'dart:ui';

import 'package:flutter/material.dart';

class AppDimen {
  static final double xxxlPadding = 120;
  static final double xlPadding = 64.0;
  static final double largePadding = 32.0;
  static final double midLargePadding = 24.0;
  static final double defaultPadding = 20.0;
  static final double midPadding = 16.0;
  static final double smallPadding = 8.0;
  static final double xsPadding = 4.0;

  static const double buttonElevation = 0.0;

  //icon sizes:
  static final double defaultIconSize = 64.0;
  static final double mediumIconSize = 40.0;
  static final double smallIconSize = 16.0;
  static final double separatorSize = 1.0;

  //widget sizes:
  static final Size appBarHeight = Size.fromHeight(100.0);

  //widget radius
  static const double defaultCornerRadius = 20.0;
  static const double smallCornerRadius = 5.0;

  //durations
  static final Duration shortDuration = Duration(seconds: 1);

  //text sizes
  static const double headline1 = 30.0;
  static const double headline2 = 20.0;
  static const double subtitle1 = 14.0;
  static const double subtitle2 = 12.0;
  static const double bodyText = 10.0;
}
