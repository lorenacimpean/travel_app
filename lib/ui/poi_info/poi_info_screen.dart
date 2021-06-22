import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/poi_info/poi_info_view_model.dart';
import 'package:travel_app/ui/widgets/back_button_widget.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';
import 'package:travel_app/ui/widgets/loading_widget.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/round_container_widget.dart';
import 'package:travel_app/utils/ui_model.dart';
import 'package:travel_app/utils/widget_utils.dart';

class PoiInfoScreen extends StatefulWidget {
  final PointModel point;

  PoiInfoScreen({
    Key key,
    this.point,
  }) : super(key: key);

  @override
  PoiInfoScreenState createState() => PoiInfoScreenState();
}

class PoiInfoScreenState extends BaseState<PoiInfoScreen> {
  PoiInfoViewModel _vm;
  bool _showLoading = false;

  @override
  void initState() {
    super.initState();
    _vm = PoiInfoViewModel(Input(PublishSubject()));
    _bindViewModel();
  }

  void _bindViewModel() {
    disposeLater(_vm.output.openMaps.listen((response) {
      switch (response.state) {
        case OperationState.loading:
          _showLoading = true;
          break;
        case OperationState.error:
          _showLoading = false;
          displayErrorModal(context, response.error);
          break;
        case OperationState.ok:
          _showLoading = false;
          WidgetUtils.launchMapsWithWayPoints(response.data);
          break;
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _showLoading
            ? LoadingWidget()
            : Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    RoundContainerWidget(
                      widgetType: WidgetType.photoOverlay,
                      imgUrl: widget.point.imageUrl,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimen.defaultPadding,
                        horizontal: AppDimen.defaultPadding,
                      ),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: BackButtonWidget(
                              onBackTapped: () => Navigator.of(context).pop())),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppDimen.xxxlPadding),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: BlurredButton(text: widget.point?.name ?? ""),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 4 +
                          AppDimen.smallPadding,
                      left: MediaQuery.of(context).size.width / 4,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AppIcons.play_icon,
                        // fit: BoxFit.fitHeight,
                      ),
                    ),
                    _screenContent(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _screenContent() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 4 + AppDimen.smallPadding,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: AppDimen.largePadding,
            vertical: AppDimen.xxxlPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
                  child: Text(
                    AppStrings.description,
                    style: AppTextStyle.headline1,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
                  child: Text(
                    widget.point.description ?? "",
                    style: AppTextStyle.subtitle2.copyWith(
                      fontSize: AppDimen.subtitle1,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
                  child: Text(
                    AppStrings.startPoint,
                    style: AppTextStyle.headline2.copyWith(),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
                  child: Text(
                    widget.point.address ?? "",
                    style: AppTextStyle.subtitle2.copyWith(
                      fontSize: AppDimen.subtitle1,
                    ),
                  ),
                ),
                Center(
                    child: PinkButton(
                  text: AppStrings.openMaps,
                  onTap: () => _vm.input.onOpenMapTapped.add(widget.point),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
