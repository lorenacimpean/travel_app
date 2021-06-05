import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/ui/intro/intro_screen.dart';
import 'package:travel_app/ui/profile/profile_view_model.dart';
import 'package:travel_app/ui/widgets/app_edit_text.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/form_screen.dart';
import 'package:travel_app/ui/widgets/loading_widget.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/ui_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends BaseState<ProfileScreen> {
  List<AppInputFieldModel> _formModels = [];
  bool _showLoading = false;
  ProfileViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = ProfileViewModel(Input(
      PublishSubject(),
      PublishSubject(),
      PublishSubject(),
      PublishSubject(),
    ));
    _bindViewModel();
    _vm.input.onStart.add(true);
  }

  void _bindViewModel() {
    disposeLater(_vm.output.loadFields.listen((response) {
      setState(() {
        if (response is Error) {
          displayErrorModal(this.context, response.toString());
        }
        _formModels = response;
      });
    }));

    disposeLater(_vm.output.onEditResult.listen((response) {
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
            break;
        }
      });
    }));

    disposeLater(_vm.output.onLogout.listen((response) {
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
                MaterialPageRoute(builder: (context) => IntroScreen()),
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
      leftIcon: AppIcons.menuIcon,
      title: AppStrings.profile,
      body: _showLoading
          ? LoadingWidget()
          : Stack(
              children: [
                FormContainer(
                  formFields: _formFields(),
                  buttonText: AppStrings.confirm,
                  onTap: () => _vm.input.onConfirm.add(true),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: AppDimen.xxlPadding),
                    child: PinkButton(
                      text: AppStrings.logout,
                      onTap: () => _vm.input.logout.add(true),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
