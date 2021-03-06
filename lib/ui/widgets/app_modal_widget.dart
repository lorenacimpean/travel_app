import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';

class AppModalWidget extends StatelessWidget {
  final String title;
  final double maxHeight;
  final List<Widget> actions;
  final Widget body;

  const AppModalWidget({
    Key key,
    this.title,
    this.maxHeight,
    this.actions,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimen.defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimen.defaultCornerRadius)),
          boxShadow: [AppColors.defaultShadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(
                        horizontal: AppDimen.largePadding,
                        vertical: AppDimen.defaultPadding)
                    .copyWith(bottom: AppDimen.smallPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  height: maxHeight,
                  padding: EdgeInsets.symmetric(
                      vertical: AppDimen.smallPadding,
                      horizontal: AppDimen.largePadding),
                  child: body,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(AppDimen.largePadding)
                  .copyWith(top: AppDimen.smallPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalWidgetDescriptor {
  final String titleKey;
  final Widget body;
  final bool hasCloseButtonInTitle;
  final double maxHeight;
  final List<Widget> actions;

  ModalWidgetDescriptor(
    this.titleKey,
    this.body,
    this.actions, {
    this.hasCloseButtonInTitle = false,
    this.maxHeight,
  });

  factory ModalWidgetDescriptor.errorDescriptor(
      String errorMessage, Function onClose) {
    return ModalWidgetDescriptor(
      "error",
      Text(
        errorMessage,
        style: AppTextStyle.subtitle2,
      ),
      [PinkButton(text: "close", onTap: onClose)],
    );
  }
}
