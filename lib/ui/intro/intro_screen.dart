import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/login/login_screen.dart';
import 'package:travel_app/ui/sign_up/sign_up_screen.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimen.defaultPadding),
                        child: Text(
                          "Hello there,Welcome Onboard!",
                          style: AppTextStyle.headline1
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppDimen.defaultPadding),
                    child: BlurredButton(
                      text: "Login with email",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppDimen.defaultPadding),
                    child: BlurredButton(
                      text: "Create account",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
