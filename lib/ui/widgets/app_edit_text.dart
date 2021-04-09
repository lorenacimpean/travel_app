import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_strings.dart';

enum FieldType {
  firstName,
  lastName,
  emailAddress,
  password,
  confirmPassword,
}

typedef OnAppInputFieldChange(AppInputFieldModel model);

class AppInputFieldWidget extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller;
  final String label;
  final String error;
  final ValueChanged<String> onValueChanged;

  AppInputFieldWidget({
    Key key,
    this.controller,
    this.textInputType,
    this.label,
    this.error,
    this.onValueChanged,
  }) : super(key: key);

  factory AppInputFieldWidget.fromModel({AppInputFieldModel model}) {
    return AppInputFieldWidget(
      textInputType: model.textInputType,
      controller: model.textController,
      label: model.label,
      error: model.error,
      onValueChanged: (newValue) {
        model.value = newValue;
        model.onValueChanged(model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: error == null
          ? Theme.of(context).textTheme.subtitle2
          : Theme.of(context).textTheme.button,
      controller: controller,
      decoration: InputDecoration(
        errorText: error,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: error == null
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).errorColor,
                width: 2)),
        labelText: label,
        labelStyle: error == null
            ? Theme.of(context).textTheme.subtitle1
            : Theme.of(context).textTheme.button,
      ),
      keyboardType: textInputType,
      onChanged: onValueChanged,
    );
  }
}

class AppInputFieldModel {
  final FieldType fieldType;
  final TextEditingController textController;
  final OnAppInputFieldChange onValueChanged;
  String error;
  String value;

  AppInputFieldModel(
      {this.fieldType,
      this.textController,
      this.error,
      this.value,
      this.onValueChanged});

  String get label {
    switch (fieldType) {
      case FieldType.firstName:
        return AppStrings.firstName;
        break;
      case FieldType.lastName:
        return AppStrings.lastName;
        break;
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
      case FieldType.firstName:
      case FieldType.lastName:
        return TextInputType.text;
        break;
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
  int get hashCode => fieldType.hashCode ^ error.hashCode ^ value.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AppInputFieldModel &&
          fieldType == other.fieldType &&
          error == other.error &&
          value == other.value;
}
