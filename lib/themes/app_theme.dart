import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.darkGrey,
      accentColor: AppColors.darkGrey,
      errorColor: AppColors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Nunito',
      textTheme: TextTheme(
        headline1: AppTextStyle.headline1,
        headline2: AppTextStyle.headline2,
        subtitle1: AppTextStyle.subtitle1,
        subtitle2: AppTextStyle.subtitle2,
        bodyText1: AppTextStyle.bodyText1,
        bodyText2: AppTextStyle.bodyText2,
        button: AppTextStyle.button,
      ),
    );
  }
}
