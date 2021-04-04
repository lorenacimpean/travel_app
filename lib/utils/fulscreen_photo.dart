import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_dimen.dart';

class FullScreenPhoto extends StatelessWidget {
  final AssetImage image;

  const FullScreenPhoto({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimen.xlPadding),
      height: double.infinity,
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
      ),
    );
  }
}
