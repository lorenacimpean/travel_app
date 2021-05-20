import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/widgets/app_modal_widget.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  List<StreamSubscription> _subscriptions = [];

  void disposeLater(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  @override
  void dispose() {
    _subscriptions?.forEach((element) {
      element?.cancel();
    });
    _subscriptions?.clear();
    super.dispose();
  }

  void displayErrorModal(BuildContext context, String error) {
    showDialog(
        context: context,
        barrierColor: AppColors.white,
        builder: (context) {
          return AppModalWidget(
            title: error.toString(),
            actions: [
              PinkButton(
                text: AppStrings.ok,
                onTap: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }
}
