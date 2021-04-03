import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';

class ColorPainter extends CustomPainter {
  final Paint _paint;
  final Path _path;

  ColorPainter({Paint paint, Path path})
      : _paint = paint ?? Paint(),
        _path = path ?? Path();

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = AppColors.darkGrey;
    _paint.style = PaintingStyle.fill;
    _path.moveTo(0, size.height * 0.3);
    _path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.30);
    _path.lineTo(size.width, 0);
    _path.lineTo(0, 0);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
