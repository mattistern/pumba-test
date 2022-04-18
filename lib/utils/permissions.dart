import 'package:notification_permissions/notification_permissions.dart' as np;
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> checkPermissionLocationGranted() async {
    var status = await Permission.location.status.isGranted;
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    //var status = await Permission.location.isGranted;
    return status;
  }

  static Future<PermissionStatus> askPermissionLocation() async {
    var status = await Permission.location.request();
    return status;
  }

  static Future<np.PermissionStatus> askPermissionNotification() async {
    np.PermissionStatus status =
        await np.NotificationPermissions.requestNotificationPermissions();

    return status;
  }
}
