import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';

class PinkButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PinkButton({
    Key key,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimen.defaultCornerRadius,
          ),
        ),
      ),
      color: AppColors.primary,
      textColor: AppColors.white,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
      onPressed: onTap,
      disabledColor: AppColors.lightGrey,
      disabledTextColor: AppColors.appWhite,
      elevation: AppDimen.buttonElevation,
    );
  }
}
