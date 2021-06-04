import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: AppColors.primary,
    ));
  }
}
