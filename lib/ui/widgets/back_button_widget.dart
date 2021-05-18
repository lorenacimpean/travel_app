import 'package:flutter/cupertino.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_icons.dart';

class BackButtonWidget extends StatelessWidget{
  final VoidCallback onBackTapped;

  const BackButtonWidget({Key key, this.onBackTapped}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: onBackTapped,
     child: Container(
       height: AppDimen.mediumIconSize,
       width: AppDimen.mediumIconSize,
       child: Padding(
         padding: EdgeInsets.all(AppDimen.smallPadding),
         child: Image(
           fit: BoxFit.contain,
           image: AppIcons.back_icon,
         ),
       ),
     ),
   );
  }

}