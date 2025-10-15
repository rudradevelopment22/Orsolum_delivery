import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: ColorConst.primaryShade35,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        // alignment: AlignmentGeometry.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "tital",
                  style: TextStyles.headline5.copyWith(color: ColorConst.white),
                ),
                _infoTile(
                  icon: AssetConst.wallet,
                  text: "Earn Rs 25,000 per month",
                ),
                _infoTile(icon: AssetConst.clock, text: "8 - 19 hours per day"),
                _infoTile(icon: AssetConst.calendar, text: "6 days per week"),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConst.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Select",
                    style: TextStyles.button.copyWith(
                      color: ColorConst.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -26,
            right: -26,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorConst.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConst.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: ColorConst.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AssetConst.clockFilled,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile({required String icon, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: ColorConst.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset(icon, height: 24, width: 24),
        ),
        const Gap(10),
        Text(
          text,
          style: TextStyles.subTitle2.copyWith(color: ColorConst.white),
        ),
      ],
    );
  }
}
