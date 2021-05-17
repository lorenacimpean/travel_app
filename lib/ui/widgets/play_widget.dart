import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';

class PlayIconWidget extends StatelessWidget {
  static final _widgetSize = 46.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widgetSize,
      height: _widgetSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimen.smallPadding),
        child: Image(
          color: AppColors.primary,
          image: AppIcons.play_icon,
        ),
      ),
    );
  }
}
