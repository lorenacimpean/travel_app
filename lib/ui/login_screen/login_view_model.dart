import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/repo/auth_repo.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/utils/dependency_factory.dart';
import 'package:travel_app/utils/ui_model.dart';

class LoginViewModel {
  final Input input;
  final AuthRepo _authRepo;
  Output output;
  List<AppInputFieldModel> _list = [];

  LoginViewModel(
    this.input, {
    AuthRepo authRepo,
  }) : _authRepo = authRepo ?? DependencyFactory.authRepo() {
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

    Stream<UIModel<bool>> _onSignIn = input.signIn.flatMap((_) {
      try {
        return _authRepo
            .login(
                email: _list?.first?.textValue,
                password: _list?.last?.textValue)
            .map((result) {
          return UIModel.success(true);
        }).startWith(UIModel.loading());
      } catch (e) {
        debugPrint(e.toString());
        return Stream.error(UIModel<bool>.error(e));
      }
    });

    output = Output(MergeStream([_loginFields, _fieldsChanged]), _onSignIn);
  }
}

class Input {
  final Subject<bool> loadFields;
  final Subject<AppInputFieldModel> valueChanged;
  final Subject<bool> signIn;

  Input(
    this.loadFields,
    this.valueChanged,
    this.signIn,
  );
}

class Output {
  final Stream<List<AppInputFieldModel>> onFieldsLoaded;
  final Stream<UIModel<bool>> onSignIn;

  Output(this.onFieldsLoaded, this.onSignIn);
}
