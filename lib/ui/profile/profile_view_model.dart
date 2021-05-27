import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/repo/auth_repo.dart';
import 'package:travel_app/repo/profile_repo.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/utils/dependencies_factory.dart';
import 'package:travel_app/utils/field_validator.dart';
import 'package:travel_app/utils/ui_model.dart';

class ProfileViewModel {
  final Input input;
  final ProfileRepo _profileRepo;

  Output output;
  List<AppInputFieldModel> _list = [];
  final AppTextValidator _validator;

  ProfileViewModel(this.input,
      {AuthRepo authRepo, AppTextValidator validator, ProfileRepo profileRepo})
      : _validator = validator ?? DependenciesFactory.appTextValidator(),
        _profileRepo = profileRepo ?? DependenciesFactory.profileRepo() {
    Stream<UIModel<bool>> _confirmResult = input.onConfirm.flatMap((value) {
      if (_list.isNotEmpty && _list.areAllFieldsValid()) {
        String firstName = _list
            .firstWhere((element) => element.fieldType == FieldType.firstName)
            .textValue;
        String lastName = _list
            .firstWhere((element) => element.fieldType == FieldType.lastName)
            .textValue;
        String email = _list
            .firstWhere(
                (element) => element.fieldType == FieldType.emailAddress)
            .textValue;
        return _profileRepo
            .updateProfileData(
                firstName: firstName, lastName: lastName, email: email)
            .map((event) {
              return UIModel.success(true);
            })
            .startWith(UIModel.loading())
            .onErrorReturnWith((error) => UIModel.error(error));
      }
      return Stream.empty();
    });

    Stream<List<AppInputFieldModel>> _profileFields =
        input.onStart.flatMap((value) {
      return _profileRepo.getUserInfo().map((profile) {
        _list.add(AppInputFieldModel(
          textValue: '',
          image: AppIcons.user_icon,
          error: null,
          fieldType: FieldType.firstName,
          textController: TextEditingController()
            ..text = profile.firstName ?? '',
          onValueChanged: (model) {
            input.valueChanged.add(model);
          },
        ));
        _list.add(AppInputFieldModel(
          textValue: '',
          image: AppIcons.user_icon,
          error: null,
          fieldType: FieldType.lastName,
          textController: TextEditingController()
            ..text = profile.lastName ?? '',
          onValueChanged: (model) {
            input.valueChanged.add(model);
          },
        ));
        _list.add(AppInputFieldModel(
          textValue: profile.email ?? '',
          image: AppIcons.emailIcon,
          error: null,
          fieldType: FieldType.emailAddress,
          textController: TextEditingController()..text = profile.email ?? '',
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
        return _list;
      });
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
  final Subject<bool> onStart;
  final Subject<AppInputFieldModel> valueChanged;
  final Subject<bool> onConfirm;

  Input(this.onStart, this.valueChanged, this.onConfirm);
}

class Output {
  final Stream<List<AppInputFieldModel>> loadFields;
  final Stream<UIModel<bool>> onEditResult;

  Output(this.loadFields, this.onEditResult);
}
