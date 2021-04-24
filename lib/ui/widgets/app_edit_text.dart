import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';

enum FieldType { emailAddress, password, confirmPassword }

typedef OnAppInputFieldChange(AppInputFieldModel model);

class AppInputFieldWidget extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller;
  final String label;
  final String error;
  final ValueChanged<String> onValueChanged;
  final AssetImage image;

  AppInputFieldWidget({
    Key key,
    this.controller,
    this.textInputType,
    this.label,
    this.error,
    this.onValueChanged,
    this.image,
  }) : super(key: key);

  factory AppInputFieldWidget.fromModel({AppInputFieldModel model}) {
    return AppInputFieldWidget(
      textInputType: model.textInputType,
      controller: model.textController,
      label: model.label,
      error: model.error,
      image: model.image,
      onValueChanged: (newValue) {
        model.textValue = newValue;
        model.onValueChanged(model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: TextFormField(
            style: error == null
                ? Theme.of(context).textTheme.subtitle2
                : Theme.of(context).textTheme.button,
            controller: controller,
            decoration: InputDecoration(
              errorText: error,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: error == null
                        ? AppColors.darkGrey
                        : Theme.of(context).errorColor,
                    width: AppDimen.separatorSize),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: error == null
                        ? AppColors.darkGrey
                        : Theme.of(context).errorColor,
                    width: AppDimen.separatorSize),
              ),
              labelText: label,
              labelStyle: error == null
                  ? AppTextStyle.subtitle1
                  : Theme.of(context).textTheme.button,
            ),
            keyboardType: textInputType,
            onChanged: onValueChanged,
            obscureText: textInputType == TextInputType.visiblePassword,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: AppDimen.defaultPadding,
              right: AppDimen.smallPadding,
            ),
            child: Image(image: image),
          ),
        ),
      ],
    );
  }
}

class AppInputFieldModel {
  final FieldType fieldType;
  final TextEditingController textController;
  final OnAppInputFieldChange onValueChanged;
  final AssetImage image;
  String error;
  String textValue;

  AppInputFieldModel({
    @required this.image,
    @required this.textValue,
    @required this.fieldType,
    this.textController,
    this.error,
    this.onValueChanged,
  });

  String get label {
    switch (fieldType) {
      case FieldType.emailAddress:
        return AppStrings.emailAddress;
        break;
      case FieldType.password:
        return AppStrings.password;
        break;
      case FieldType.confirmPassword:
        return AppStrings.confirmPassword;
        break;

      default:
        return null;
    }
  }

  TextInputType get textInputType {
    switch (fieldType) {
      case FieldType.emailAddress:
        return TextInputType.emailAddress;
        break;
      case FieldType.password:
      case FieldType.confirmPassword:
        return TextInputType.visiblePassword;
        break;
      default:
        return null;
    }
  }

  @override
  int get hashCode => fieldType.hashCode ^ error.hashCode ^ textValue.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AppInputFieldModel &&
          fieldType == other.fieldType &&
          error == other.error &&
          textValue == other.textValue;
}

extension ModelFromFieldType on List<AppInputFieldModel> {
  AppInputFieldModel getModelFromFieldType(FieldType fieldType) {
    AppInputFieldModel model = this?.firstWhere(
        (model) => model.fieldType == fieldType,
        orElse: () => null);
    return model;
  }

  bool areAllFieldsValid() {
    return this.firstWhere(
            (field) => field.error != null || field.textValue == null,
            orElse: () => null) ==
        null;
  }
}
