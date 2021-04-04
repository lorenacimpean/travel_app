import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_theme.dart';
import 'package:travel_app/ui/intro_screen/intro_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().appTheme(context),
      home: IntroScreen(),
    );
  }
}
