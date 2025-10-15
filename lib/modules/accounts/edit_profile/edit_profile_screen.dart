import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/accounts/edit_profile/edit_profile_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyles.headline6),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Name
                  Text("First Name", style: TextStyles.subTitle2Semibold),
                  const Gap(4),
                  TextField(
                    controller: controller.firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const Gap(12),

                  // Last Name
                  Text("Last Name", style: TextStyles.subTitle2Semibold),
                  const Gap(4),
                  TextField(
                    controller: controller.lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const Gap(12),

                  // Phone
                  Text("Email", style: TextStyles.subTitle2Semibold),
                  const Gap(4),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const Gap(12),

                  // // City
                  // Text("City", style: TextStyles.subTitle2Semibold),
                  // const Gap(4),
                  // TextField(
                  //   controller: controller.cityController,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     contentPadding: EdgeInsets.symmetric(
                  //       horizontal: 12,
                  //       vertical: 8,
                  //     ),
                  //   ),
                  // ),
                  // const Gap(12),
                  //
                  // // State
                  // Text("State", style: TextStyles.subTitle2Semibold),
                  // const Gap(4),
                  // TextField(
                  //   controller: controller.stateController,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     contentPadding: EdgeInsets.symmetric(
                  //       horizontal: 12,
                  //       vertical: 8,
                  //     ),
                  //   ),
                  // ),
                  // const Gap(12),

                  // Date of Birth
                  Text("Date of Birth", style: TextStyles.subTitle2Semibold),
                  const Gap(4),
                  TextField(
                    controller: controller.dobController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Update Button
            Obx(
              () =>
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                        text: "Update Profile",
                        onTap: () => controller.updateUserProfile(),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.dobController.text =
          "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  String _getMonthName(int month) {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][month - 1];
  }
}
