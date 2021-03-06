import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/repo/auth_repo.dart';
import 'package:travel_app/repo/profile_repo.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/utils/dependencies_factory.dart';
import 'package:travel_app/utils/field_validator.dart';
import 'package:travel_app/utils/ui_model.dart';

class SignUpViewModel {
  final Input input;
  final AuthRepo _authRepo;
  final ProfileRepo _profileRepo;
  Output output;
  List<AppInputFieldModel> _list = [];
  final AppTextValidator _validator;

  SignUpViewModel(this.input,
      {AuthRepo authRepo, AppTextValidator validator, ProfileRepo profileRepo})
      : _authRepo = authRepo ?? DependenciesFactory.authRepo(),
        _validator = validator ?? DependenciesFactory.appTextValidator(),
        _profileRepo = profileRepo ?? DependenciesFactory.profileRepo() {
    Stream<UIModel<bool>> _signUpResult = input.signUp.flatMap((value) {
      if (_list.areAllFieldsValid()) {
        return _authRepo
            .signUp(
                email: _list?.first?.textValue,
                password: _list?.last?.textValue)
            .asBroadcastStream()
            .flatMap((credential) {
              return _profileRepo
                  .updateProfileData(email: credential.user.email)
                  .map((_) {
                return UIModel.success(true);
              });
            })
            .startWith(UIModel.loading())
            .onErrorReturnWith((error, stacktrace) {
              return UIModel.error(error);
            });
      }
      return Stream.empty();
    });

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

    Stream<List<AppInputFieldModel>> _onSignUp = input.signUp.flatMap((_) {
      String password = _list
          .firstWhere((element) => element.fieldType == FieldType.password)
          .textValue;
      _list.forEach((model) {
        model.error = _validator.validate(model, password: password);
      });
      if (_list.areAllFieldsValid()) {
        _signUpResult.map((value) {
          return _list;
        });
      }
      return Stream.value(_list);
    });

    output = Output(
        MergeStream([
          _signUpFields,
          _fieldsChanged,
          _onSignUp,
        ]),
        _signUpResult);
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
