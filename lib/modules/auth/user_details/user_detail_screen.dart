import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/auth/user_details/user_detail_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/validation_utils.dart';

import '../../../constant/asset_const.dart';

class UserDetailScreen extends GetView<UserDetailController> {
  const UserDetailScreen({super.key});

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
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name"),
                              const Gap(6),
                              TextFormField(
                                controller: controller.nameTextEditController,
                                keyboardType: TextInputType.name,
                                validator:
                                    (value) => ValidationUtils.name(value),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: "Enter your first name",
                                ),
                              ),
                              const Gap(10),
                              Text("Last Name"),
                              const Gap(6),
                              TextFormField(
                                controller:
                                    controller.lastNameTextEditController,
                                keyboardType: TextInputType.name,
                                validator:
                                    (value) => ValidationUtils.name(value),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: "Enter your last name",
                                ),
                              ),
                              const Gap(10),
                              Text("Date of Birth"),
                              const Gap(6),
                              TextFormField(
                                controller:
                                    controller.dateOfBirthTextEditController,
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your date of birth";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: "Enter your date of birth",
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () async {
                                      final now = DateTime.now();
                                      final initialDate = now.subtract(
                                        const Duration(days: 365 * 18),
                                      );
                                      final firstDate = DateTime(1900);
                                      final lastDate = now;
                                      final pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: firstDate,
                                        lastDate: lastDate,
                                      );
                                      if (pickedDate != null) {
                                        controller
                                            .dateOfBirthTextEditController
                                            .text = pickedDate
                                                .toIso8601String()
                                                .split('T')
                                                .first;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Text("Email"),
                              const Gap(6),
                              TextFormField(
                                controller: controller.emailTextEditController,
                                keyboardType: TextInputType.emailAddress,
                                validator:
                                    (value) => ValidationUtils.email(value),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: "Enter your email",
                                ),
                              ),
                              const Gap(10),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),

                      const Spacer(),
                      CustomButton(text: "Next", onTap: controller.onNextTap),
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
