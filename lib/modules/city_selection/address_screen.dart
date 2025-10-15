import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
                      Text("Enter Your Address", style: TextStyles.headline5),
                      const Gap(10),
                      Text(
                        "Please fill details and upload required documents.",
                        style: TextStyles.subTitle1,
                      ),
                      const Gap(30),

                      // ---------- Form ----------
                      BackgroundContainer(child: _addressDetails()),
                      const Gap(20),

                      const Spacer(),

                      // ---------- Button ----------
                      CustomButton(text: "Next", onTap: () {}),
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

  Widget _addressDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Flat No./House No."),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Flat No./House No.",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Street Name"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Street Name",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Landmark"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Landmark",
            suffixIcon: Icon(Icons.calendar_today),
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("City"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "city",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("State"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "state",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
        Text("Select address type"),
        const Gap(6),
        TextField(
          // controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "select",
          ),
          // onChanged: validateInput,
        ),
        const Gap(10),
      ],
    );
  }
}
