import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/auth/auth_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/utils/validation_utils.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text("Sign in to you account", style: TextStyles.headline5),
            const Gap(10),
            Text("Login or create an account", style: TextStyles.subTitle1),
            const Gap(30),
            BackgroundContainer(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.phoneTextEditController,
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text("🇮🇳", style: TextStyle(fontSize: 20)),
                        ),
                        counterText: "",
                        hintText: "Enter a mobile number",
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => controller.onLoginTap(),
                      onChanged: (_) {
                        controller.loginErrorText.value = null;
                        controller.loginFormKey.currentState?.validate();
                      },
                      validator: (value) => ValidationUtils.phoneNumber(value),
                      // onChanged: validateInput,
                    ),
                    const Gap(10),
                    Obx(
                      () =>
                          controller.loginErrorText.value != null
                              ? Text(
                                controller.loginErrorText.value!,
                                style: TextStyles.subTitle2.copyWith(
                                  color: ColorConst.accentDanger,
                                ),
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don’t have an account ? ",
                    style: TextStyles.subTitle2.copyWith(
                      color: ColorConst.grey500,
                    ),
                  ),
                  TextSpan(
                    text: "Create new account",
                    style: TextStyles.subTitle2Bold.copyWith(
                      color: ColorConst.primaryShade50,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(RouterUtils.register);
                          },
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(text: "Continue", onTap: controller.onLoginTap),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
