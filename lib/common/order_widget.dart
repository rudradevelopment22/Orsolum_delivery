import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text("New", style: TextStyle(color: Colors.blueAccent)),
              ),
              Column(
                children: [
                  Text("John Doe", style: TextStyles.headline6),
                  Text("ORD-2024-001", style: TextStyles.subTitle2),
                ],
              ),
            ],
          ),
          const Gap(6),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AssetConst.box, height: 16, width: 16),
                      const Gap(8),
                      Text(
                        "Powder Garden Mix Soil",
                        style: TextStyles.subTitle2,
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(children: [const Gap(24), Text("25Kg x 1")]),
                ],
              );
            },
            separatorBuilder: (context, index) => const Gap(4),
            itemCount: 1,
          ),
          const Gap(6),
          Row(
            children: [
              SvgPicture.asset(AssetConst.location, height: 16, width: 16),
              const Gap(8),
              Text("12, Patel Nager, Surat - 395001"),
            ],
          ),
          const Gap(6),
          Row(
            children: [
              SvgPicture.asset(
                AssetConst.clock,
                colorFilter: ColorFilter.mode(
                  ColorConst.accentInfo,
                  BlendMode.srcIn,
                ),
                height: 16,
                width: 16,
              ),
              const Gap(8),
              Text("30-40 mi"),
              const Gap(10),
              SvgPicture.asset(
                AssetConst.route,
                colorFilter: ColorFilter.mode(
                  ColorConst.accentInfo,
                  BlendMode.srcIn,
                ),
                height: 16,
                width: 16,
              ),
              const Gap(8),
              Text("2.5 Km"),
            ],
          ),
          const Gap(14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterUtils.orderDetailsScreen);
                  },
                  child: Container(
                    height: 42,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConst.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: ColorConst.white,
                          size: 16,
                        ),
                        const Gap(4),
                        Text(
                          "Accept",
                          style: TextStyles.button.copyWith(
                            color: ColorConst.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Container(
                  height: 42,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: ColorConst.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.close, color: ColorConst.primary, size: 16),
                      const Gap(4),
                      Text("Skip", style: TextStyles.button),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
