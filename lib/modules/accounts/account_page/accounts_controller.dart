import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/models/user_model.dart';
import 'package:orsolum_delivery/modules/home/home_controller.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/utils/storage_utils.dart';

class AccountsController extends GetxController {
  final _homeController = Get.find<HomeController>();
  final _storage = StorageUtils.instance;

  // Get the current user
  User get currentUser => _homeController.user.value;
  
  // Check if user is logged in
  bool get isLoggedIn => currentUser.id.isNotEmpty;

  // User's full name
  String get fullName =>
      '${currentUser.firstName} ${currentUser.lastName}'.trim();

  // Logout user
  Future<void> logout() async {
    try {
      // TODO: Add any API call for logout if needed
      // await ApiService.logout();

      // Clear user data
      await _storage.removeUserDetails();

      // Reset home controller state
      _homeController.user.value = User();

      // Navigate to login screen
      Get.offAllNamed(RouterUtils.login);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
