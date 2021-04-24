import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';

class DummyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: "TEST SCREEN",
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.pink,
      ),
    );
  }
}
