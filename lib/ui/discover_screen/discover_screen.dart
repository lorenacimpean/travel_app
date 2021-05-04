import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      leftIcon: AppIcons.menuIcon,
      title: AppStrings.discover,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
