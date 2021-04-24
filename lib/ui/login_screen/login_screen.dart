import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/login_screen/login_view_model.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/form_screen.dart';
import 'package:travel_app/utils/base_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  LoginViewModel _vm;
  List<AppInputFieldModel> _formModels = [];

  @override
  void initState() {
    super.initState();
    _vm = LoginViewModel(Input(
      PublishSubject(),
      PublishSubject(),
    ));

    _bindViewModel();
    _vm.input.loadFields.add(true);
  }

  void _bindViewModel() {
    disposeLater(_vm.output.onFieldsLoaded.listen((models) {
      setState(() {
        _formModels = models;
      });
    }));
  }

  List<Widget> _formFields() {
    List<Widget> list = [];
    _formModels.forEach((model) {
      list.add(
        Expanded(
          child: AppInputFieldWidget.fromModel(
            model: model,
          ),
        ),
      );
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.login,
      body: FormContainer(
        formFields: _formFields(),
        buttonText: "Sign in",
      ),
    );
  }
}
