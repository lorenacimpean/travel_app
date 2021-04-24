import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> formFields;
  final String buttonText;
  final VoidCallback onTap;

  const FormContainer({
    Key key,
    this.formFields,
    this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.loose,
      children: [
        Positioned(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(AppDimen.defaultPadding),
              padding: EdgeInsets.symmetric(
                horizontal: AppDimen.defaultPadding,
                vertical: AppDimen.midLargePadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimen.mediumCornerRadius),
                ),
                boxShadow: [AppColors.defaultShadow],
              ),
              child: Padding(
                padding: EdgeInsets.all(AppDimen.defaultPadding),
                child: Wrap(
                  children: _items(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _items() {
    List<Widget> items = formFields;
    items.add(
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: AppDimen.largePadding),
        child: PinkButton(
          text: buttonText,
        ),
      ),
    );
    return items;
  }
}
