import 'package:flutter/material.dart';
import 'package:location/location.dart' as l;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_app/themes/app_strings.dart';
import 'package:travel_app/themes/app_text_styles.dart';
import 'package:travel_app/ui/widgets/app_modal_widget.dart';
import 'package:travel_app/ui/widgets/pink_button.dart';

mixin PermissionHandler {
  Stream<PermissionStatus> hasPermission(Permission permission) {
    return permission.status.asStream();
  }

  Stream<PermissionStatus> requestPermission(Permission permission) {
    return permission.request().asStream();
  }

  Stream<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissions) {
    return permissions.request().asStream();
  }

  Stream<bool> handleLocationPermission(BuildContext context, {int tries = 3}) {
    return Permission.locationAlways
        .request()
        .asStream()
        .flatMap((permissionStatus) {
      if (permissionStatus == PermissionStatus.permanentlyDenied ||
          permissionStatus == PermissionStatus.restricted ||
          tries <= 0) {
        return showOpenSettingsDialog(context, "weNeedLocationPermission")
            .map((event) => false);
      }
      return handleLocationService(context, tries).flatMap((serviceStatus) {
        if (tries <= 0) {
          return Stream.value(false);
        }
        if (serviceStatus && permissionStatus == PermissionStatus.granted) {
          return Stream.value(true);
        }
        return handleLocationPermission(context, tries: tries - 1);
      });
    });
  }

  Stream<dynamic> showOpenSettingsDialog(
      BuildContext context, String permissionTextKey) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: AppModalWidget(
              title: AppStrings.requestPermissionTitle,
              body: Text(AppStrings.requestPermissionText,
                  style: AppTextStyle.headline2.copyWith(fontSize: 14)),
              actions: [
                PinkButton(
                  text: AppStrings.openSettings,
                  onTap: () {
                    openAppSettings()
                        .then((_) => Navigator.of(context).pop(true));
                  },
                )
              ],
            ),
          );
        }).asStream();
  }

  Stream<bool> handleLocationService(BuildContext context, int tries) {
    return l.Location().requestService().asStream().flatMap((isOk) {
      if (isOk) {
        return Stream.value(true);
      }
      if (tries > 0) {
        return handleLocationPermission(context, tries: tries - 1);
      }
      return Stream.value(false);
    });
  }
}
