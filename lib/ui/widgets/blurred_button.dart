import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_text_styles.dart';

class BlurredButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double _sigmaX = 10.0; // from 0-10
  final double _sigmaY = 10.0; // from 0-10

  const BlurredButton({
    Key key,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimen.defaultCornerRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: TextButton(
          onPressed: onTap,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimen.smallPadding),
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.button2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
