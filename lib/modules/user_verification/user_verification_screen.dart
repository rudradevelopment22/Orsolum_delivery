import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/custom/upload_card.dart';
import 'package:orsolum_delivery/modules/user_verification/user_verification_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

import '../../../constant/asset_const.dart';

class UserVerificationScreen extends GetView<UserVerificationController> {
  const UserVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final step = controller.currentStep;

        // ✅ Success bottom sheet
        if (step == 5) {
          Future.microtask(() => _showSuccessSheet(context));
        }

        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorConst.primaryShade10, ColorConst.neutralShade5],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.04, 0.1],
            ),
          ),
          padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(),
                        const Gap(24),

                        // ---------- Title ----------
                        Text(_title(step), style: TextStyles.headline5),
                        const Gap(10),
                        Text(_subtitle(step), style: TextStyles.subTitle1),
                        const Gap(30),

                        // ---------- Form ----------
                        BackgroundContainer(child: _form(step)),
                        const Gap(20),

                        const Spacer(),

                        // ---------- Button ----------
                        CustomButton(
                          text: step == 4 ? "Finish" : "Next",
                          onTap: controller.submitStep,
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _header() {
    return Row(
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
        const Gap(54),
      ],
    );
  }

  String _title(int step) {
    switch (step) {
      case 0:
        return "Fill out bank details";
      case 1:
        return "Enter your PAN details";
      case 2:
        return "Enter your Aadhaar details";
      case 3:
        return "Enter your vehicle details";
      case 4:
        return "Enter your license details";
      default:
        return "";
    }
  }

  String _subtitle(int step) {
    switch (step) {
      case 0:
        return "Please fill details of the bank account where you want your earnings";
      case 1:
        return "Please fill your PAN details";
      case 2:
        return "Please provide Aadhaar details";
      case 3:
        return "Please fill details of the vehicle you will be using for deliveries";
      case 4:
        return "Please provide the details of your driving license";
      default:
        return "";
    }
  }

  Widget _form(int step) {
    switch (step) {
      case 0:
        return _bankDetails();
      case 1:
        return _panDetails();
      case 2:
        return _aadharDetails();
      case 3:
        return _vehicleDetails();
      case 4:
        return _licenseDetails();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _bankDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose your bank"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Bank",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Enter your bank account number"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Account Number",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Enter your bank account number"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Confirm Account Number",
            suffixIcon: Icon(Icons.calendar_today),
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Enter your bank IFSC code "),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Bank IFSC Code",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
      ],
    );
  }

  Widget _panDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter PAN number"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "PAN Number",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Name on PAN Card"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Name",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Date of Birth"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Select Date",
            suffixIcon: Icon(Icons.calendar_today),
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Select Gender"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Select Gender",
          ),
          // onChanged: validateInput,
        ),
        const Gap(20),
        UploadCard(
          title: "PAN card photo",
          subtitle: "Front side image only",
          buttonText: "Take Photo",
          onPressed: () {
            // open camera
          },
        ),
      ],
    );
  }

  Widget _aadharDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Aadhaar number"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Aadhaar Number",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Name on Aadhaar Card"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Name",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Date of Birth"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Select Date",
            suffixIcon: Icon(Icons.calendar_today),
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        UploadCard(
          title: "Aadhaar card photo",
          subtitle: "Front side image only",
          buttonText: "Take Photo",
          onPressed: () {
            // open camera
          },
        ),
      ],
    );
  }

  // TODO: you already have _bankDetails(), _panDetails(), _aadharDetails()
  // Just add these two:

  Widget _vehicleDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vehicle type"),
        const Gap(6),
        TextField(decoration: const InputDecoration(hintText: "Type")),
        const Gap(10),
        Text("Vehicle number"),
        const Gap(6),
        TextField(decoration: const InputDecoration(hintText: "Number")),
        const Gap(10),
        Text("Insurance number"),
        const Gap(6),
        TextField(decoration: const InputDecoration(hintText: "Insurance No.")),
        const Gap(20),
        UploadCard(
          title: "Upload registration certificate",
          subtitle: "Front side image only",
          buttonText: "Take Photo",
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _licenseDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter your full name"),
        const Gap(6),
        TextField(decoration: const InputDecoration(hintText: "Full Name")),
        const Gap(10),
        Text("Enter your license number"),
        const Gap(6),
        TextField(
          decoration: const InputDecoration(hintText: "License Number"),
        ),
        const Gap(10),
        Text("License expiry date"),
        const Gap(6),
        TextField(
          decoration: const InputDecoration(
            hintText: "Expiry Date",
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
        const Gap(20),
        UploadCard(
          title: "Upload License Photo",
          subtitle: "JPG, PNG or PDF (max 5MB)",
          buttonText: "Take Photo",
          onPressed: () {},
        ),
      ],
    );
  }

  void _showSuccessSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, color: Colors.green, size: 80),
                const Gap(16),
                Text(
                  "Verification has been done successfully !!",
                  style: TextStyles.headline5,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                Text(
                  "Your profile has been set up successfully. Complete your bike and location details to start deliveries.",
                  style: TextStyles.subTitle1,
                  textAlign: TextAlign.center,
                ),
                const Gap(24),
                CustomButton(text: "Continue", onTap: () => Get.back()),
              ],
            ),
          ),
    );
  }
}
