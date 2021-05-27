import 'package:flutter/cupertino.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      leftIcon: AppIcons.menuIcon,
      title: AppStrings.privacyPolicy,
      body: body,
    );
  }

  Widget get body {
    return Padding(
      padding: EdgeInsets.all(AppDimen.defaultPadding),
      child: SingleChildScrollView(
        child: Text(
          AppStrings.privacyPolicyText,
          style: AppTextStyle.label.copyWith(fontSize: AppDimen.subtitle1),
        ),
      ),
    );
  }
}
