import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'earnings_controller.dart';

class EarningsReportPage extends StatelessWidget {
  const EarningsReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earnings"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: ColorConst.screenBg,
      body: GetBuilder<EarningsController>(
        init: EarningsController(),
        builder: (controller) {
          return Column(
            children: [
              // Tabs
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      _buildTab(controller, "Daily"),
                      _buildTab(controller, "Weekly"),
                      _buildTab(controller, "Monthly"),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Earnings Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorConst.neutralShade10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: ColorConst.neutralShade5,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.dateRangeText,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(2),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                          const Gap(8),
                          Obx(
                            () => Text(
                              "₹${controller.earnings.value.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),

                    // Orders + Time
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorConst.neutralShade10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _infoCard("4", "Orders", icon: Icons.shopping_bag),
                          Container(width: 1, height: 40, color: Colors.grey),
                          _infoCard(
                            "03:10 hr",
                            "Time on orders",
                            icon: Icons.access_time,
                            color: ColorConst.accentInfo,
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),

                    // Order earnings
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorConst.neutralShade10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConst.primary.withValues(alpha: 0.2),
                            ),
                            child: Icon(
                              Icons.shopping_bag,
                              color: ColorConst.primary,
                              size: 16,
                            ),
                          ),
                          const Gap(4),
                          const Text(
                            "Order earning",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Text(
                            "535 ₹",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTab(EarningsController controller, String title) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.changeTab(title),
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color:
                  controller.selectedTab.value == title
                      ? ColorConst.primary
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    controller.selectedTab.value == title
                        ? Colors.white
                        : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(
    String value,
    String label, {
    required IconData icon,
    Color? color,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      color?.withValues(alpha: 0.2) ??
                      ColorConst.primary.withValues(alpha: 0.2),
                ),
                padding: EdgeInsets.all(4),
                child: Icon(icon, color: color ?? ColorConst.primary, size: 16),
              ),
              const Gap(8),
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
