import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_dimen.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/discover/discover_screen.dart';
import 'package:travel_app/ui/navigation_menu/navigation_menu_view_model.dart';
import 'package:travel_app/ui/profile/profile_screen.dart';
import 'package:travel_app/ui/support/support_screen.dart';
import 'package:travel_app/utils/base_state.dart';
import 'package:travel_app/utils/round_container_widget.dart';

import '../privacy_policy/privacy_policy_screen.dart';

class NavigationMenu extends StatefulWidget {
  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends BaseState<NavigationMenu> {
  static final Duration _animationDuration = Duration(milliseconds: 200);
  List<MenuItemDescriptor> _itemList;
  NavigationMenuViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = NavigationMenuViewModel(Input(PublishSubject()));
    _bindViewModel();
    _vm.input.onStart.add(true);
  }

  void _bindViewModel() {
    disposeLater(_vm.output.menuItems.listen((list) {
      setState(() {
        _itemList = list;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: _animationDuration,
            child: RoundContainerWidget(
              widgetType: WidgetType.navigation,
            ),
          ),
          _itemList != null ? _menuItems() : Container(),
        ],
      ),
    );
  }

  Widget _menuItems() {
    return Padding(
      padding: EdgeInsets.only(top: AppDimen.xlPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _items(),
      ),
    );
  }

  List<Widget> _items() {
    return _itemList.map((i) {
      return MenuEntryWidget(i, () => _goToNext(i.type));
    }).toList();
  }

  void _goToNext(NavigationMenuEntry entry) {
    Widget screen;
    switch (entry) {
      case NavigationMenuEntry.discover:
        screen = DiscoverScreen();
        break;
      case NavigationMenuEntry.profile:
        screen = ProfileScreen();
        break;
      case NavigationMenuEntry.privacyPolicy:
        screen = PrivacyPolicyScreen();
        break;
      case NavigationMenuEntry.contactSupport:
        screen = SupportScreen();
        break;
      default:
        screen = DiscoverScreen();
    }
    setState(() {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => screen));
    });
  }
}

class MenuEntryWidget extends StatelessWidget {
  final MenuItemDescriptor descriptor;
  final VoidCallback onTap;

  MenuEntryWidget(this.descriptor, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppDimen.smallPadding),
        child: Text(
          descriptor.text,
          style: AppTextStyle.button2.copyWith(fontSize: AppDimen.headline2),
        ),
      ),
    );
  }
}
