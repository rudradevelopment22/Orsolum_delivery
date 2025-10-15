import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class SettleCollectionScreen extends StatelessWidget {
  const SettleCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedTab = "Today";

    final List<String> tabs = ["Today", "Yesterday", "Last 7 days"];

    return Scaffold(
      appBar: AppBar(title: const Text("Settle Collection"), centerTitle: true),
      backgroundColor: ColorConst.grey100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorConst.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorConst.grey200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Collection",
                          style: TextStyles.body2.copyWith(
                            color: ColorConst.grey400,
                          ),
                        ),
                        const Gap(5),
                        Text("₹ 1240", style: TextStyles.headline5),
                        const Gap(5),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorConst.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorConst.grey200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To be returned",
                          style: TextStyles.body2.copyWith(
                            color: ColorConst.grey400,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          "₹ 1020",
                          style: TextStyles.headline5.copyWith(
                            color: ColorConst.accentDanger,
                          ),
                        ),
                        const Gap(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children:
                    tabs.map((tab) {
                      bool selected = selectedTab == tab;
                      return GestureDetector(
                        onTap: () {
                          selectedTab = tab;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                selected ? Colors.green : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tab,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const Gap(10),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SettlementWidget();
              },
              separatorBuilder: (context, index) => const Gap(10),
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class SettlementWidget extends StatelessWidget {
  const SettlementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConst.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConst.grey200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AssetConst.shop2, height: 25, width: 25),
              const Gap(10),
              Text(
                "Fresh Mart Grocery",
                style: TextStyles.subTitle1Large.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              const Gap(5),
              Container(
                decoration: BoxDecoration(
                  color: ColorConst.accentWarning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                child: Text(
                  "Pending",
                  style: TextStyles.caption.copyWith(
                    color: ColorConst.accentWarning,
                  ),
                ),
              ),
            ],
          ),
          const Gap(4),
          Row(
            children: [
              SvgPicture.asset(AssetConst.location),
              const Gap(5),
              Text("123 Main street, Downtown"),
            ],
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Collection",
                      style: TextStyles.button.copyWith(
                        color: ColorConst.grey400,
                      ),
                    ),
                    const Gap(5),
                    Text("₹ 1240", style: TextStyles.headline6),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To be returned",
                      style: TextStyles.button.copyWith(
                        color: ColorConst.grey400,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "₹ 1020",
                      style: TextStyles.headline6.copyWith(
                        color: ColorConst.accentDanger,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
          const Gap(10),
          Divider(),
          const Gap(10),
        ],
      ),
    );
  }
}
