import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/cash_collection_widget.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/modules/cash_collection/cash_collection_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

class CashCollectionPage extends GetView<CashCollectionController> {
  // final CashCollectionController controller = Get.put(
  //   CashCollectionController(),
  // );

  const CashCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cash Collection"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Total Container
            Obx(
              () => GestureDetector(
                onTap: () {
                  Get.toNamed(RouterUtils.settleCollection);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorConst.primaryShade30,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Cash Collection",
                                style: TextStyles.caption.copyWith(
                                  color: ColorConst.white,
                                ),
                              ),
                              Text(
                                "₹ ${controller.total.value}",
                                style: TextStyles.headline5.copyWith(
                                  color: ColorConst.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorConst.primaryShade35,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.money, color: ColorConst.white),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Updated: Today, 1:20 PM",
                            style: TextStyle(color: ColorConst.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.arrow_forward,
                              color: ColorConst.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Recent Collections", style: TextStyles.headline6),
            ),
            SizedBox(height: 20),
            // Recent Collections List
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.recentCollections.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = controller.recentCollections[index];
                    return CashCollectionWidget(data: item);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
