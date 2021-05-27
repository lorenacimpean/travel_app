import 'package:flutter/cupertino.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';
import 'package:travel_app/utils/widget_utils.dart';

class SupportScreen extends StatelessWidget {
  static final _height = 200.0;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      leftIcon: AppIcons.menuIcon,
      title: AppStrings.contactSupport,
      body: body,
    );
  }

  Widget get body {
    return Center(
      child: Container(
        height: _height,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimen.defaultCornerRadius,
            ),
          ),
          child: Column(
            children: [
              Text(
                AppStrings.howCanWeHelp,
                style: AppTextStyle.headline1,
              ),
              Padding(
                padding: EdgeInsets.only(top: AppDimen.largePadding),
                child: PinkButton(
                  text: AppStrings.callSupport,
                  onTap: () => WidgetUtils.launchDialerWithSupportPhone(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
