import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double _appBarHeight = 100;

  const CustomAppBar(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AppIcons.lights,
        ),
        Text(title)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
