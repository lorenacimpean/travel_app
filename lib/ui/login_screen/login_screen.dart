import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/dummy_screen.dart';
import 'package:travel_app/ui/login_screen/login_view_model.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/form_screen.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/ui_model.dart';

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
    disposeLater(_vm.output.onSignIn.listen((response) {
      switch (response.state) {
        case OperationState.loading:
          // TODO: Handle this case.
          break;
        case OperationState.error:
          // TODO: Handle this case.
          break;
        case OperationState.ok:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DummyScreen(),
            ),
          );
          break;
      }
    }));
  }

  List<Widget> _formFields() {
    List<Widget> list = [];
    _formModels.forEach((model) {
      list.add(
        AppInputFieldWidget.fromModel(
          model: model,
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
        onTap: () => _vm.input.signIn.add(true),
      ),
    );
  }
}
