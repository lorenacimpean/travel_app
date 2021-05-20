import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/navigation_menu/navigation_menu.dart';

class AppScreen extends StatelessWidget {
  final String title;
  final Widget body;
  final AssetImage leftIcon;
  final AssetImage rightIcon;

  const AppScreen({
    Key key,
    @required this.title,
    @required this.body,
    this.leftIcon,
    this.rightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.primary,
          icon: leftIcon != null ? Image(image: leftIcon) : Container(),
          onPressed: leftIcon != null
              ? () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NavigationMenu()))
              : null,
        ),
        title: Text(
          title,
          style: AppTextStyle.headline1,
        ),
        actions: [
          IconButton(
            color: AppColors.primary,
            icon: rightIcon != null ? Image(image: rightIcon) : Container(),
            onPressed: () => print("Tapped right icon"),
          ),
        ],
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: body,
      drawer: NavigationMenu(),
    );
  }
}
