
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/custom/custom_dropdown_field.dart';
import 'package:orsolum_delivery/modules/auth/auth_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: BackButtonWidget(),
                            ),
                          ),
                          Image.asset(AssetConst.orsolumTextLogo, height: 46),
                          Gap(54),
                        ],
                      ),
                      const Gap(24),
                      Text("Create an Account", style: TextStyles.headline5),
                      const Gap(10),
                      Text(
                        "Enter your details to create your Orsolum account",
                        style: TextStyles.subTitle1,
                      ),
                      const Gap(30),
                      BackgroundContainer(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: controller.registerFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State"),
                              const Gap(6),
                              Obx(
                                () => CustomDropdownField(
                                  hintText: 'Select State',
                                  selectedValue:
                                      controller.selectedState.value.isEmpty
                                          ? null
                                          : controller.selectedState.value,
                                  items:
                                      controller.states
                                          .map((e) => e.name)
                                          .toList(),
                                  onChanged: (String value) {
                                    controller.selectedState.value = value;

                                    // find selected state & update its cities
                                    final state = controller.states.firstWhere(
                                      (element) => element.name == value,
                                    );
                                    controller.selectedStateCities =
                                        state.cities.obs;
                                    controller.selectedCity.value = '';
                                  },
                                ),
                              ),
                              const Gap(10),
                              Text("City"),
                              const Gap(6),
                              Obx(
                                () => CustomDropdownField(
                                  hintText: 'Select City',
                                  selectedValue:
                                      controller.selectedCity.value.isEmpty
                                          ? null
                                          : controller.selectedCity.value,
                                  items:
                                      controller.selectedStateCities
                                          .map((e) => e.name)
                                          .toList(),
                                  onChanged: (String value) {
                                    controller.selectedCity.value = value;
                                  },
                                ),
                              ),
                              const Gap(10),
                              Text("Phone Number"),
                              const Gap(6),
                              TextFormField(
                                controller: controller.phoneTextEditController,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: "Enter your phone number",
                                ),
                                onChanged: (_) {
                                  controller.registerFormKey.currentState
                                      ?.validate();
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Phone number required";
                                  } else if (val.length != 10) {
                                    return "Enter valid 10 digit number";
                                  }
                                  return null;
                                },
                              ),
                              const Gap(10),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),

                      const Spacer(),
                      CustomButton(
                        text: "Register",
                        onTap: controller.onRegisterTap,
                      ),
                      const Gap(20),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyles.subTitle2.copyWith(
                                  color: ColorConst.grey500,
                                ),
                              ),
                              TextSpan(
                                text: "Login",
                                style: TextStyles.subTitle2Bold.copyWith(
                                  color: ColorConst.primaryShade50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
