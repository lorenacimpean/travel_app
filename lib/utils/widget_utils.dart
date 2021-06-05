import 'package:travel_app/models/location_model.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetUtils {
  static const String googleMapsDeeplink =
      "https://www.google.com/maps/dir/?api=1";
  static const String supportPhone = "0756355916";

  static void launchMapsWithWayPoints(List<LocationModel> locations) async {
    String link = googleMapsDeeplink;
    //current location is always starting point
    link += "&origin=${locations.first.string}";
    link += "&destination=${locations.last.string}";
    String waypoints = "&waypoints=";
    for (int i = 1; i < locations.length - 1; i++) {
      waypoints += locations[i].string;
    }
    link += waypoints;
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not open the map.';
    }
  }

  static void launchDialerWithSupportPhone() {
    launch("tel://$supportPhone");
  }
}
