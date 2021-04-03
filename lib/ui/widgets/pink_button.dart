import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';

class PinkButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double _sigmaX = 10.0; // from 0-10
  final double _sigmaY = 10.0; // from 0-10
  final double _opacity = 0.2; // from 0-1.0

  const PinkButton({
    Key key,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //   return Container(
    //     child: BackdropFilter(
    //       filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
    //       child: Container(
    //         color: AppColors.lightGrey.withOpacity(_opacity),
    //       ),
    //     ),
    //   );
    // }

    return RaisedButton(
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
