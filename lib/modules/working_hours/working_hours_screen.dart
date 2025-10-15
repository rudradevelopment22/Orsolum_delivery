import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/working_hours_widget.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class WorkingHoursScreen extends StatelessWidget {
  const WorkingHoursScreen({super.key});

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
        padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
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
            Text("Select Working Hours", style: TextStyles.headline5),
            const Gap(10),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gap(10),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return WorkingHoursWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
