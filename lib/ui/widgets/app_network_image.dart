import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  static final _defaultImageHeight = 200.0;
  final String url;

  const AppNetworkImage(
    this.url, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      height: _defaultImageHeight,
      width: _defaultImageHeight,
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
