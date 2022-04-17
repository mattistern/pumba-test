import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> checkPermissionLocation() async {
    var status = await Permission.location.isGranted;
    return status;
  }

  static Future<PermissionStatus> askPermissionLocation() async {
    var status = await Permission.location.request();
    return status;
  }

  static Future<PermissionStatus> askPermissionNotification() async {
    var status = await Permission.notification.request();
    return status;
  }
}
