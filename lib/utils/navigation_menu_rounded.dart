import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';

class NavigationMenu extends StatelessWidget {
  // @override
  // State<FullScreen> createState() => _RoundPhotoWidgetState();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: PhotoClipper(),
      child: Container(
        color: AppColors.primary,
      ),
    );
  }
}

class PhotoClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
      center: Offset(10, 0),
      height: size.height * 1.2,
      width: size.width * 2,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
