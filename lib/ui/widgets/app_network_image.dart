import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  final imageHeight;
  final imageWidth;
  final String url;

  AppNetworkImage(
    this.url, {
    Key key,
    this.imageHeight = 200.0,
    this.imageWidth = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: imageHeight,
      width: imageWidth,
      child: Image.network(
        url ?? "",
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primary,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) =>
                Icon(
          Icons.error,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
