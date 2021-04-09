import 'package:flutter/material.dart';
import 'package:travel_app/ui/widgets/app_bar_widget.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title),
        body: body,
      ),
    );
  }
}
