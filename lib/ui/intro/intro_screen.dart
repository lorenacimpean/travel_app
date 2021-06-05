import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/login/login_screen.dart';
import 'package:travel_app/ui/sign_up/sign_up_screen.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AppIcons.mainPhoto,
            fit: BoxFit.fitHeight,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3,
                    right: AppDimen.largePadding,
                    bottom: AppDimen.xxxlPadding),
                child: Text(
                  AppStrings.welcomeMessage,
                  style:
                      AppTextStyle.headline1.copyWith(color: AppColors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppDimen.defaultPadding),
                child: BlurredButton(
                  text: AppStrings.loginEmail,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppDimen.defaultPadding),
                child: BlurredButton(
                  text: AppStrings.createAccount,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
