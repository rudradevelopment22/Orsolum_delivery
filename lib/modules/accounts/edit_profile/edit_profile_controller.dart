import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orsolum_delivery/api/api.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/modules/home/home_controller.dart';
import 'package:orsolum_delivery/utils/enum.dart';

class EditProfileController extends GetxController {
  final _homeController = Get.find<HomeController>();
  final RxBool isLoading = false.obs;

  // Text controllers
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController dobController;
  late final TextEditingController emailController;

  // late final TextEditingController cityController;
  // late final TextEditingController stateController;

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers with user data from HomeController
    final user = _homeController.user.value;
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    emailController = TextEditingController(text: user.email);
    // cityController = TextEditingController(text: user.city);
    // stateController = TextEditingController(text: user.state);

    // Format date of birth
    final dobText =
        user.dob != null ? DateFormat('yyyy-MM-dd').format(user.dob!) : '';
    dobController = TextEditingController(text: dobText);
  }

  @override
  void onClose() {
    // Dispose controllers when not needed
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    // cityController.dispose();
    // stateController.dispose();
    super.onClose();
  }

  // Method to update user data
  Future<void> updateUserProfile() async {
    try {
      isLoading.value = true;

      final response = await Api.client.put(
        endPoint: ApiConst.updateUser,
        requestBody: {
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
          "email": emailController.text.trim(),
          // "city": cityController.text.trim(),
          // "state": stateController.text.trim(),
          "dob": dobController.text.trim(),
        },
      );

      if (response.status == ApiStatus.success) {
        // Create updated user data
        final updatedUser = _homeController.user.value;
        updatedUser.firstName = firstNameController.text.trim();
        updatedUser.lastName = lastNameController.text.trim();
        updatedUser.email = emailController.text.trim();
        // updatedUser.dob = DateTime.parse(dobController.text.trim());

        // Update the user in HomeController
        _homeController.user.value = updatedUser;

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }

      // Optionally navigate back
      // Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
