import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> formFields;

  const FormContainer({
    Key key,
    this.formFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(AppDimen.defaultPadding),
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
            children: formFields,
          ),
        ),
      ),
    );
  }
}
