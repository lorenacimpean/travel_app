import 'package:flutter/cupertino.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/utils/photo_painter.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhotoOverlay(
      image: AppIcons.mainPhoto,
    );
  }
}
