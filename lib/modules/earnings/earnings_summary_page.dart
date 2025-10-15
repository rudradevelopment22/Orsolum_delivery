import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

class EarningsSummaryPage extends StatelessWidget {
  const EarningsSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earnings", style: TextStyles.buttonLarge),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Earnings Card
          GestureDetector(
            onTap: () {
              Get.toNamed(RouterUtils.earningsReport);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Earning: 17 Feb - 23 Feb",
                          style: TextStyles.buttonLarge,
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  const Gap(8),
                  const Text(
                    "₹0",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Gap(16),

          // Pocket Section
          Align(
            alignment: Alignment.center,
            child: const Text(
              "Pocket",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(12),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Pocket Balance"),
                    Text(
                      "0 ₹",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Available Withdraw Limit"),
                    Text(
                      "750 ₹",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Divider(),
                const Gap(8),
                CustomButton(text: "Withdraw", onTap: () {}),
              ],
            ),
          ),
          const Gap(20),

          // Other Cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 100 / 60,
            // width / height
            children: [
              _smallCard(title: "₹0", subtitle: "Payout\n10 Feb - 16 Feb"),
              _smallCard(
                svgPath: AssetConst.credit,
                subtitle: "Deduction\nstatement",
                svgSize: 20,
              ),
              _smallCard(
                svgPath: AssetConst.wallet,
                subtitle: "Pocket\nStatement",
                svgSize: 20,
              ),
              _smallCard(
                svgPath: AssetConst.money,
                subtitle: "Earning in\nCash",
                svgSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallCard({
    String? title,
    String? subtitle,
    String? svgPath,
    double svgSize = 40,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (svgPath != null && svgPath.isNotEmpty)
            SvgPicture.asset(
              svgPath,
              height: svgSize,
              width: svgSize,
              colorFilter: ColorFilter.mode(
                ColorConst.primary,
                BlendMode.srcIn,
              ),
            )
          else if (title != null)
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          if (subtitle != null && subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
