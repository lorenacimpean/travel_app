import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/login_screen/login_screen.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';
import 'package:travel_app/ui/widgets/indicator_widget.dart';
import 'package:travel_app/utils/fulscreen_photo.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            FullScreenPhoto(image: AppIcons.lights),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppDimen.xlPadding),
                        child: Text(
                          "Hello there,Welcome Onboard!",
                          style: AppTextStyle.headline2
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppDimen.smallPadding),
                    child: BlurredButton(
                      text: "Continue with Facebook",
                      onTap: () => LoginScreen(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppDimen.smallPadding),
                    child: BlurredButton(
                      text: "Login with email",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppDimen.smallPadding),
                    child: BlurredButton(
                      text: "Create account",
                      onTap: () => print("tapped"),
                    ),
                  ),
                  IndicatorWidget(total: 3, selected: 0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
