import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/repo/auth_repo.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/utils/dependencies_factory.dart';
import 'package:travel_app/utils/field_validator.dart';
import 'package:travel_app/utils/ui_model.dart';

class ProfileViewModel {
  final Input input;
  final AuthRepo _authRepo;
  Output output;
  List<AppInputFieldModel> _list = [];
  final AppTextValidator _validator;

  ProfileViewModel(
    this.input, {
    AuthRepo authRepo,
    AppTextValidator validator,
  })  : _authRepo = authRepo ?? DependenciesFactory.authRepo(),
        _validator = validator ?? DependenciesFactory.appTextValidator() {
    Stream<UIModel<bool>> _confirmResult = input.onConfirm.flatMap((value) {
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
    });
    Stream<List<AppInputFieldModel>> _profileFields =
        input.loadFields.flatMap((value) {
      _list.add(AppInputFieldModel(
        textValue: '',
        image: AppIcons.user_icon,
        error: null,
        fieldType: FieldType.name,
        textController: TextEditingController(),
        onValueChanged: (model) {
          input.valueChanged.add(model);
        },
      ));
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
    Stream<List<AppInputFieldModel>> _onConfirm = input.onConfirm.flatMap((_) {
      String password = "";
      _list.forEach((model) {
        if (model.fieldType == FieldType.password) password = model.textValue;
        model.error = _validator.validate(model, password: password);
      });
      if (_list.areAllFieldsValid()) {
        _confirmResult.map((value) {
          return _list;
        });
      }
      return Stream.value(_list);
    });

    output = Output(
        MergeStream([
          _profileFields,
          _fieldsChanged,
          _onConfirm,
        ]),
        _confirmResult);
  }
}

class Input {
  final Subject<bool> loadFields;
  final Subject<AppInputFieldModel> valueChanged;
  final Subject<bool> onConfirm;

  Input(this.loadFields, this.valueChanged, this.onConfirm);
}

class Output {
  final Stream<List<AppInputFieldModel>> onFieldsLoaded;
  final Stream<UIModel<bool>> onEditResult;

  Output(this.onFieldsLoaded, this.onEditResult);
}
