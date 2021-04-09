import 'package:flutter/cupertino.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/form_screen.dart';

class LoginScreen extends StatelessWidget {
  List<Widget> _formFields() {
    AppInputFieldModel model = AppInputFieldModel(
      fieldType: FieldType.firstName,
      value: "Test",
    );

    return [AppInputFieldWidget.fromModel(model: model)];
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: "Login Screen",
      body: FormContainer(formFields: _formFields()),
    );
  }
}
