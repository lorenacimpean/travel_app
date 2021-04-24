import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';

class LoginViewModel {
  final Input input;
  Output output;
  List<AppInputFieldModel> _list = [];

  LoginViewModel(this.input) {
    Stream<List<AppInputFieldModel>> _loginFields =
        input.loadFields.flatMap((value) {
      _list.add(AppInputFieldModel(
        textValue: '',
        image: AppIcons.emailIcon,
        fieldType: FieldType.emailAddress,
        textController: TextEditingController(),
        onValueChanged: (model) {
          input.valueChanged.add(model);
        },
      ));
      _list.add(AppInputFieldModel(
        textValue: '',
        image: AppIcons.keyIcon,
        fieldType: FieldType.password,
        textController: TextEditingController(),
        onValueChanged: (model) {
          input.valueChanged.add(model);
        },
      ));
      return Stream.value(_list);
    });

    Stream<List<AppInputFieldModel>> _fieldsChanged =
        input.valueChanged.map((field) {
      field.error = null;
      _list
          .firstWhere((element) => element.fieldType == field.fieldType,
              orElse: () => null)
          ?.textValue = field.textValue;
      return _list;
    });
    output = Output(MergeStream([
      _loginFields,
      _fieldsChanged,
    ]));
  }
}

class Input {
  final Subject<bool> loadFields;
  final Subject<AppInputFieldModel> valueChanged;

  Input(this.loadFields, this.valueChanged);
}

class Output {
  final Stream<List<AppInputFieldModel>> onFieldsLoaded;

  Output(this.onFieldsLoaded);
}
