import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/auth/user_details/user_detail_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

import '../../../constant/asset_const.dart';

class SelfieVerificationScreen extends GetView<UserDetailController> {
  const SelfieVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConst.primaryShade10, ColorConst.neutralShade5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.04, 0.1],
          ),
        ),
        padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Column(
          children: [
            /// Top row (Back + Logo + Spacer)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: BackButtonWidget(),
                ),
                Image.asset(AssetConst.orsolumTextLogo, height: 46),
                const Gap(54),
              ],
            ),
            const Gap(24),

            /// Title
            Text("Selfie Verification", style: TextStyles.headline5),
            const Gap(10),
            Text("Position your face", style: TextStyles.subTitle1),
            const Gap(30),

            /// White background container
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConst.neutralShade30,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: const Icon(Icons.person, size: 80, color: Colors.grey),
            ),

            /// Instructions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle, size: 18, color: Colors.green),
                    Gap(6),
                    Expanded(
                      child: Text("Keep your face centered within the circle"),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: const [
                    Icon(Icons.check_circle, size: 18, color: Colors.green),
                    Gap(6),
                    Expanded(child: Text("Ensure good lighting")),
                  ],
                ),
                const Gap(10),
                Row(
                  children: const [
                    Icon(Icons.check_circle, size: 18, color: Colors.green),
                    Gap(6),
                    Expanded(child: Text("Hold your device at eye level")),
                  ],
                ),
              ],
            ),
            const Gap(20),

            /// Take Selfie button
            CustomButton(
              text: "Take Selfie",
              onTap: () async {
                final image = await Get.toNamed(RouterUtils.selfieCamera);
                if (image == null) return;

                // Normalize return type to XFile
                try {
                  if (image is XFile) {
                    controller.imageFile.value = image;
                  } else if (image is String) {
                    controller.imageFile.value = XFile(image);
                  } else if (image is File) {
                    controller.imageFile.value = XFile(image.path);
                  } else {
                    Get.snackbar("Error", "Unsupported image type returned");
                    return;
                  }

                  await controller.uploadSelfie();
                } catch (e) {
                  Get.snackbar("Error", "Failed to process selfie: $e");
                }
              },
            ),
            const Gap(20),

            /// Tips section
            BackgroundContainer(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Tips for best result",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Gap(10),
                    Text("   • Remove glasses or face covering"),
                    Text("   • Find a well-lit area"),
                    Text("   • Look directly at the camera"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
