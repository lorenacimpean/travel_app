import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';

class DiscoverScreen extends StatelessWidget {
  static final double _cardSize = 150;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      leftIcon: AppIcons.menuIcon,
      title: AppStrings.discover,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: [_textWidget(), _cardWidget()],
    );
  }

  Widget _textWidget() {
    return Padding(
      padding: EdgeInsets.all(AppDimen.defaultPadding),
      child: Text(
        AppStrings.dummyText,
        style: AppTextStyle.button,
      ),
    );
  }

  Widget _cardWidget() {
    return Padding(
      padding: EdgeInsets.all(AppDimen.defaultPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimen.defaultCornerRadius,
          ),
        ),
        child: Stack(
          children: [
            InkWell(
              child:
                  Image.asset(AppIcons.mainPhoto.assetName, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(AppDimen.defaultPadding),
              child: BlurredButton(
                text: AppStrings.dummyText,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: AppDimen.xlPadding),
                height: _cardSize,
                width: _cardSize,
                child: Image(
                  fit: BoxFit.contain,
                  image: AppIcons.play_icon,
                  // fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
