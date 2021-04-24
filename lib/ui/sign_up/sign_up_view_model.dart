import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/repo/auth_repo.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/utils/dependency_factory.dart';
import 'package:travel_app/utils/field_validator.dart';
import 'package:travel_app/utils/ui_model.dart';

class SignUpViewModel {
  final Input input;
  final AuthRepo _authRepo;
  Output output;
  List<AppInputFieldModel> _list = [];
  final AppTextValidator _validator;

  SignUpViewModel(
    this.input, {
    AuthRepo authRepo,
    AppTextValidator validator,
  })  : _authRepo = authRepo ?? DependencyFactory.authRepo(),
        _validator = validator ?? DependencyFactory.appTextValidator() {
    Stream<UIModel<bool>> _signUpResult() {
      if (_list.isNotEmpty) {
        try {
          return _authRepo
              .signUp(
                  email: _list?.first?.textValue,
                  password: _list?.last?.textValue)
              .asBroadcastStream()
              .map((result) {
            debugPrint("Signed up with ${result.credential.signInMethod}");
            return UIModel.success(true);
          });
        } catch (e) {
          debugPrint(e.toString());
          return Stream.value(UIModel.error(e));
        }
      }
      return Stream.empty();
    }

    Stream<List<AppInputFieldModel>> _signUpFields =
        input.loadFields.flatMap((value) {
      _list.add(AppInputFieldModel(
        textValue: '',
        image: AppIcons.emailIcon,
        error: null,
        fieldType: FieldType.emailAddress,
        textController: TextEditingController(),
        onValueChanged: (model) {
          input.valueChanged.add(model);
        },
      ));
      _list.add(AppInputFieldModel(
        textValue: '',
        image: AppIcons.keyIcon,
        error: null,
        fieldType: FieldType.password,
        textController: TextEditingController(),
        onValueChanged: (model) {
          input.valueChanged.add(model);
        },
      ));
      _list.add(AppInputFieldModel(
        textValue: '',
        error: null,
        image: AppIcons.keyIcon,
        fieldType: FieldType.confirmPassword,
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

    Stream<List<AppInputFieldModel>> _onSignIn = input.signUp.flatMap((_) {
      String password = "";
      _list.forEach((model) {
        if (model.fieldType == FieldType.password) password = model.textValue;
        model.error = _validator.validate(model, password: password);
      });
      if (_list.areAllFieldsValid()) {
        _signUpResult().map((value) {
          return _list;
        });
      }
      return Stream.value(_list);
    });

    output = Output(
        MergeStream([
          _signUpFields,
          _fieldsChanged,
          _onSignIn,
        ]),
        _signUpResult());
  }
}

class Input {
  final Subject<bool> loadFields;
  final Subject<AppInputFieldModel> valueChanged;
  final Subject<bool> signUp;

  Input(
    this.loadFields,
    this.valueChanged,
    this.signUp,
  );
}

class Output {
  final Stream<List<AppInputFieldModel>> onFieldsLoaded;
  final Stream<UIModel<bool>> onSignUpResult;

  Output(this.onFieldsLoaded, this.onSignUpResult);
}
