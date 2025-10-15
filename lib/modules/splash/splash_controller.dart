import 'dart:async';
import 'package:get/get.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/utils/logs_utils.dart';
import 'package:orsolum_delivery/utils/storage_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      // Add a small delay to show the splash screen
      await Future.delayed(const Duration(seconds: 2));

      // Check if user is logged in
      final user = await StorageUtils.instance.getUser();

      if (user != null) {
        // User is logged in, go to home
        await Get.offAllNamed(RouterUtils.home);
      } else {
        // User is not logged in, go to login
        await Get.offAllNamed(RouterUtils.login);
      }
    } catch (e, stackTrace) {
      LogsUtils.error(
        'Error in splash screen navigation',
        error: e,
        stackTrace: stackTrace,
      );
      // Fallback to login screen in case of error
      await Get.offAllNamed(RouterUtils.login);
    }
  }
}
