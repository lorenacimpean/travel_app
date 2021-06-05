import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_dimen.dart';

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
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Padding(
          padding: EdgeInsets.all(AppDimen.largePadding),
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
