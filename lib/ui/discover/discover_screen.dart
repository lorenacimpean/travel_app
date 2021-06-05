import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/route_model.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/route_details/route_details_screen.dart';
import 'package:travel_app/ui/widgets/app_network_image.dart';
import 'package:travel_app/ui/widgets/base_screen.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/permission_handler.dart';
import 'package:travel_app/utils/ui_model.dart';

import 'discover_view_model.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  DiscoverScreenState createState() => DiscoverScreenState();
}

class DiscoverScreenState extends BaseState<DiscoverScreen>
    with PermissionHandler {
  static final double _playButtonSize = 150;
  DiscoverViewModel _vm;
  List<RouteModel> _routes = [];
  bool _showLoading = false;

  @override
  void initState() {
    super.initState();
    _vm = DiscoverViewModel(Input(
      PublishSubject(),
      PublishSubject(),
    ));
    _bindViewModel();
  }

  void _bindViewModel() {
    disposeLater(handleLocationPermission(context).listen((hasPermission) {
      if (hasPermission) {
        _vm.input.onStart.add(true);
      }
    }));

    disposeLater(_vm.output.loadRoutes.listen((result) {
      setState(() {
        switch (result.state) {
          case OperationState.loading:
            _showLoading = true;
            break;
          case OperationState.error:
            _showLoading = false;
            displayErrorModal(context, result.error.toString());
            break;
          case OperationState.ok:
            _routes = result.data;
            _showLoading = false;
            break;
        }
      });
    }));
    disposeLater(_vm.output.goToNext.listen((info) {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RouteDetailsScreen(
                  routeModel: info.routeModel,
                  points: info.points,
                )));
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      leftIcon: AppIcons.menuIcon,
      title: AppStrings.discover,
      body: _showLoading
          ? Container()
          : ListView(
              children: _content(),
            ),
    );
  }

  List<Widget> _content() {
    List<Widget> widgets = [];
    widgets.add(_textWidget());
    widgets.addAll(_routeCards());
    return widgets;
  }

  List<Widget> _routeCards() {
    return _routes?.map((r) => _cardWidget(r))?.toList();
  }

  Widget _textWidget() {
    return Padding(
      padding: EdgeInsets.all(AppDimen.defaultPadding),
      child: Text(
        AppStrings.discoverSubtitle,
        style: AppTextStyle.button,
      ),
    );
  }

  Widget _cardWidget(RouteModel route) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: AppDimen.defaultPadding,
              right: AppDimen.defaultPadding,
              bottom: AppDimen.largePadding),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppDimen.defaultCornerRadius,
              ),
            ),
            child: Stack(
              children: [
                InkWell(
                  onTap: () => _vm.input.onRouteTapped.add(route),
                  child: AppNetworkImage(
                    route.imgUrl,
                    imageWidth: MediaQuery.of(context).size.width,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppDimen.defaultPadding),
                      child: BlurredButton(
                        text: route.description ?? "",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppDimen.midPadding * 3,
                          left: AppDimen.defaultPadding,
                          right: AppDimen.defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Duration: ${route.duration}" ?? "",
                            style: AppTextStyle.button2,
                          ),
                          Text(
                            "Stops: ${route.pointIds.length}" ?? "",
                            style: AppTextStyle.button2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: _playButtonSize * 0.9,
          left: MediaQuery.of(context).size.width / 2 - _playButtonSize / 2,
          child: Container(
            height: _playButtonSize,
            child: Image(
              fit: BoxFit.contain,
              image: AppIcons.play_icon,
              // fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
