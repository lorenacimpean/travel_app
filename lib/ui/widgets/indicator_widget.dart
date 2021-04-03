import 'package:flutter/material.dart';
import 'package:travel_app/themes/app_colors.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';

class IndicatorWidget extends StatelessWidget {
  static final int max = 5;
  final int selected;
  final int total;

  const IndicatorWidget({Key key, @required this.total, @required selected})
      : this.selected = selected ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(AppDimen.largePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            total < 5 ? total : max,
            (index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                    image: AppIcons.dotIcon,
                    color: (_computeCurrentDot() == index)
                        ? AppColors.primary
                        : AppColors.white),
              );
            },
          ),
        ),
      ),
    );
  }

  int _computeCurrentDot() {
    int perPage = total ~/ 5 + 1;
    return (selected ~/ perPage).round();
  }
}
