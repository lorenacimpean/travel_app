import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/utils/round_photo_widget.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundPhotoWidget(
          image: AppIcons.mainPhoto,
        ),
      ],
    );
  }
}
