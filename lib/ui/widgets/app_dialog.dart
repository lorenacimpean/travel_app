import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';

class AppDialog extends StatelessWidget {
  final Color textColor;
  final Color borderColor;
  final String text;

  const AppDialog({
    Key key,
    this.textColor = AppColors.primary,
    this.borderColor = AppColors.lightGrey,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(
          vertical: AppDimen.defaultPadding,
          horizontal: AppDimen.xlPadding,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimen.smallCornerRadius,
            ),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: textColor,
              ),
        ),
      ),
    );
  }
}
