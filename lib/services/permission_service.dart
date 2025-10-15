import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService {
  static PermissionService get to => Get.find();

  final RxBool _hasNotificationPermission = false.obs;
  bool get hasNotificationPermission => _hasNotificationPermission.value;

  Future<PermissionService> init() async {
    await checkAndRequestPermissions();
    return this;
  }

  Future<void> checkAndRequestPermissions() async {
    await _checkNotificationPermission();
    // Add more permission checks here if needed
  }

  Future<bool> _checkNotificationPermission() async {
    if (GetPlatform.isWeb) return true;
    
    var status = await Permission.notification.status;
    if (status.isDenied) {
      status = await Permission.notification.request();
      if (status.isPermanentlyDenied) {
        _hasNotificationPermission.value = false;
        return false;
      }
    }
    
    _hasNotificationPermission.value = status.isGranted;
    return status.isGranted;
  }

  Future<bool> isNotificationPermissionGranted() async {
    if (kIsWeb) return true;
    return await Permission.notification.isGranted;
  }

  Future<void> openAppSettingsIfNeeded() async {
    if (!await isNotificationPermissionGranted()) {
      await openAppSettings();
    }
  }

  // Add more permission-related methods here as needed
}
