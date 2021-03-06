import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/discover/discover_screen.dart';
import 'package:travel_app/ui/login/login_view_model.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/form_screen.dart';
import 'package:travel_app/ui/widgets/loading_widget.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/ui_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  LoginViewModel _vm;
  List<AppInputFieldModel> _formModels = [];
  bool _showLoading = false;

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
    disposeLater(_vm.output.onFieldsLoaded.listen((response) {
      setState(() {
        if (response is Error) {
          displayErrorModal(this.context, response.toString());
        }
        _formModels = response;
      });
    }));
    disposeLater(_vm.output.onLoginResult.listen((response) {
      setState(() {
        switch (response.state) {
          case OperationState.loading:
            _showLoading = true;
            break;
          case OperationState.error:
            _showLoading = false;
            displayErrorModal(context, response.error.toString());
            break;
          case OperationState.ok:
            _showLoading = false;
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => DiscoverScreen()),
                (Route<dynamic> route) => false);
            break;
        }
      });
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
      body: _showLoading
          ? LoadingWidget()
          : FormContainer(
              formFields: _formFields(),
              buttonText: "Sign in",
              onTap: () => _vm.input.signIn.add(true),
            ),
    );
  }
}
