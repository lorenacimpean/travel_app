import 'package:travel_app/repo/auth_repo.dart';

import 'field_validator.dart';

class DependencyFactory {
  static AuthRepo authRepo() => AuthRepo();
  static AppTextValidator appTextValidator()=> AppTextValidator();
}
