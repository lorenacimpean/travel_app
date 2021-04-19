import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimen.dart';

class AppTextStyle {
  static const TextStyle headline1 = TextStyle(
      color: AppColors.primary,
      fontSize: AppDimen.headline1,
      fontWeight: FontWeight.bold);

  static const TextStyle headline2 = TextStyle(
      color: AppColors.primary,
      fontSize: AppDimen.headline2,
      fontWeight: FontWeight.bold);

  static const TextStyle subtitle1 = TextStyle(
      color: AppColors.primary,
      fontSize: AppDimen.subtitle1,
      fontWeight: FontWeight.bold);

  static const TextStyle subtitle2 = TextStyle(
      color: AppColors.darkGrey,
      fontSize: AppDimen.subtitle2,
      fontWeight: FontWeight.normal);

  static const TextStyle bodyText1 = TextStyle(
      color: AppColors.primary,
      fontSize: AppDimen.bodyText,
      fontWeight: FontWeight.bold);

  static const TextStyle bodyText2 = TextStyle(
      color: AppColors.white,
      fontSize: AppDimen.bodyText,
      fontWeight: FontWeight.normal);

  static const TextStyle button = TextStyle(
    color: AppColors.primary,
    fontSize: AppDimen.subtitle1,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle button2 = TextStyle(
    color: AppColors.white,
    fontSize: AppDimen.headline2,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle label = TextStyle(
    color: AppColors.darkGrey,
    fontSize: AppDimen.headline2,
    fontWeight: FontWeight.normal,
  );
}
