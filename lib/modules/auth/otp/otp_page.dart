import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/auth/auth_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends GetView<AuthController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString otp = "".obs;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConst.primaryShade10, ColorConst.neutralShade5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.04, 0.1],
          ),
        ),
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BackButtonWidget(),
              ),
            ),
            const Gap(24),

            // Title
            Text("Sign in to you account", style: TextStyles.headline5),
            const Gap(10),
            Text("Login or create an account", style: TextStyles.subTitle1),
            const Gap(30),

            // OTP box
            BackgroundContainer(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.otpFormKey,
                child: Column(
                  children: [
                    Pinput(
                      controller: controller.otpTextFieldController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      onChanged: (val) => otp.value = val,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter 6-digit OTP';
                        }
                        if (val.trim().length != 6) {
                          return 'Enter 6-digit OTP';
                        }
                        return null;
                      },
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    ),

                    const Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter 6-digit OTP send to ${controller.phoneTextEditController.text.replaceRange(0, 7, '*******')}",
                        ),
                        const Gap(4),
                        GestureDetector(
                          onTap: controller.onPencilTap,
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Obx(() {
                      return controller.otpTimerSec.value > 0
                          ? Text(
                            "${controller.otpTimerSec.value}  Resend OTP",
                            style: const TextStyle(color: Colors.green),
                          )
                          : GestureDetector(
                            onTap: controller.onResendTap,
                            child: const Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                    }),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Continue Button
            CustomButton(text: "Continue", onTap: controller.onVerifyTap),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
