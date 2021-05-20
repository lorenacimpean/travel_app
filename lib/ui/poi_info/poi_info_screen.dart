import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/models/point_model.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/poi_info/poi_info_view_model.dart';
import 'package:travel_app/ui/widgets/back_button_widget.dart';
import 'package:travel_app/ui/widgets/blurred_button.dart';
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

  @override
  void initState() {
    super.initState();
    _vm = PoiInfoViewModel(Input(PublishSubject()));
    _bindViewModel();
  }

  void _bindViewModel() {
    disposeLater(_vm.output.openMaps.listen((response) {
      setState(() {
        switch (response.state) {
          case OperationState.loading:
            // TODO: Handle this case.
            break;
          case OperationState.error:
            displayErrorModal(context, response.error);
            break;
          case OperationState.ok:
            WidgetUtils.launchMapsBetweenPoints(
                response.data.first, response.data.last);
            break;
        }
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              RoundContainerWidget(
                widgetType: WidgetType.photoOverlay,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimen.xlPadding,
                  horizontal: AppDimen.largePadding,
                ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: BackButtonWidget(
                        onBackTapped: () => Navigator.of(context).pop())),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimen.xxxlPadding),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BlurredButton(text: widget.point?.name ?? ""),
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
      padding: EdgeInsets.only(top: AppDimen.xxxlPadding * 2),
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
                  onTap: () => _vm.input.onMapsTapped.add(widget.point),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
