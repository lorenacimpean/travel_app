import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_strings.dart';

class NavigationMenuViewModel {
  final Input input;
  Output output;

  NavigationMenuViewModel(this.input) {
    Stream<List<MenuItemDescriptor>> _menuItems = input.onStart.map((value) {
      List<MenuItemDescriptor> list = [];
      NavigationMenuEntry.values.forEach((type) {
        list.add(MenuItemDescriptor.fromType(type));
      });
      return list;
    });
    output = Output(_menuItems);
  }
}

class Input {
  final Subject<bool> onStart;

  Input(this.onStart);
}

class Output {
  final Stream<List<MenuItemDescriptor>> menuItems;

  Output(this.menuItems);
}

enum NavigationMenuEntry { discover, profile, privacyPolicy, contactSupport }

class MenuItemDescriptor {
  final String text;
  final NavigationMenuEntry type;

  MenuItemDescriptor(
    this.text,
    this.type,
  );

  factory MenuItemDescriptor.fromType(NavigationMenuEntry type) {
    return MenuItemDescriptor(StringForType.getStringByType(type), type);
  }
}

extension StringForType on NavigationMenuEntry {
  static String getStringByType(type) {
    switch (type) {
      case NavigationMenuEntry.discover:
        return AppStrings.discover;
        break;
      case NavigationMenuEntry.profile:
        return AppStrings.profile;
        break;
      case NavigationMenuEntry.privacyPolicy:
        return AppStrings.privacyPolicy;
        break;
      case NavigationMenuEntry.contactSupport:
        return AppStrings.contactSupport;
        break;
      default:
        return null;
    }
  }
}
