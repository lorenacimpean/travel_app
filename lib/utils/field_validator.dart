import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';

class AppTextValidator {
  static const int minimumLength = 3;

  String textValidator(String value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldEmptyError;
    }
    if (value.length < minimumLength) {
      return AppStrings.fieldInvalidError;
    }
    return null;
  }

  String emailValidator(String value) {
    RegExp emailRegex = RegExp(r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$');
    if (value == null || value.isEmpty) {
      return AppStrings.fieldEmptyError;
    }
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailFieldInvalidError;
    }
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) {
      return AppStrings.fieldEmptyError;
    } else {
      if (value.length < 6)
        return AppStrings.fieldInvalidError;
      else
        return null;
    }
  }

  String confirmPasswordValidator(String confirm, String password) {
    if (confirm == null || confirm.isEmpty) {
      return AppStrings.fieldEmptyError;
    } else {
      if (confirm != password)
        return AppStrings.passwordsDoNotMatch;
      else
        return null;
    }
  }

  String validate(AppInputFieldModel model, {String password}) {
    switch (model.fieldType) {
      case FieldType.emailAddress:
        return emailValidator(model.textValue);
        break;
      case FieldType.password:
        return passwordValidator(model.textValue);
        break;
      case FieldType.confirmPassword:
        return confirmPasswordValidator(model.textValue, password);
        break;
      default:
        return null;
    }
  }
}
