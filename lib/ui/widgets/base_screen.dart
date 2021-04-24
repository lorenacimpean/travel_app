import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_text_styles.dart';

class AppScreen extends StatelessWidget {
  final String title;
  final Widget body;

  const AppScreen({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.primary,
          icon: Icon(Icons.add),
          onPressed: () => print("Tapped drawer"),
        ),
        title: Text(
          title,
          style: AppTextStyle.headline1,
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: body,
    );
  }
}
