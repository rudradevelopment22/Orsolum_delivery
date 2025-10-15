import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class OrderAccepted extends StatelessWidget {
  const OrderAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(AssetConst.accept)),
        const Gap(20),
        Text(
          "Order Accepted!",
          style: TextStyles.headline3.copyWith(color: ColorConst.primary),
        ),
        const Gap(12),
        Text(
          "You have successfully accepted the order Get ready to deliver!",
          style: TextStyles.subTitle1,
        ),
        const Gap(40),
        CustomButton(text: "See or der details", onTap: () {}),
      ],
    );
  }
}
