import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<PermissionStatus> checkPermissionLocation() async {
    var status = await Permission.location.status;
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    //var status = await Permission.location.isGranted;
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
