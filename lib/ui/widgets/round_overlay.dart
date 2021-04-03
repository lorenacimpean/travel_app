import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/utils/color_painter.dart';

class RoundOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     image: DecorationImage(
      //       fit: BoxFit.none,
      //       alignment: FractionalOffset.topLeft,
      //       image: AppIcons.mainPhoto,
      //     )),
      child: CustomPaint(
        painter: ColorPainter(),
      ),
      color: Colors.white,
    );
  }

  Widget _roundContainer() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('images/batman.jpg'),
    );
  }
}
