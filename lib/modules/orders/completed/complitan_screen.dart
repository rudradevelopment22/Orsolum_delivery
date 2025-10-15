import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/modules/orders/rateing/rating_screen.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.screenBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Gap(20),
            SvgPicture.asset(AssetConst.check, height: 80, width: 80),
            const Gap(14),
            Text("Order Completed!", style: TextStyles.headline4),
            const Gap(10),
            Text("February 15, 2024 • 2:47 PM", style: TextStyles.subTitle1),
            const Gap(20),
            _orderDetails(),
            const Gap(20),
            _timeDetails(),
            const Gap(20),
            _earningsTile(),
            const Gap(20),
            _customerRating(),
            const Gap(20),
            CustomButton(
              text: "Back to home",
              onTap: () {
                Get.offAllNamed(RouterUtils.home);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderDetails() {
    return BackgroundContainer(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AssetConst.credit, height: 18, width: 18),
              const Gap(4),
              Row(
                children: [Text("Order Details", style: TextStyles.subTitle1)],
              ),
            ],
          ),
          _detailsTile("Orders Id", "#ORD-12345"),
          _detailsTile("Customer Name", "John Doe"),
          _detailsTile("Delivery Address", "123 Main St, New York, NY 10001"),
          _detailsTile("Items", "3 Items"),
        ],
      ),
    );
  }

  Widget _timeDetails() {
    return BackgroundContainer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConst.accentInfo.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetConst.clock,
                        color: ColorConst.accentInfo,
                        height: 18,
                        width: 18,
                      ),
                      const Gap(6),
                      Text("Time Taken"),
                      const Gap(6),
                      Text("20 min", style: TextStyles.subTitle2),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConst.accentInfo.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetConst.location,
                        color: ColorConst.accentInfo,
                        height: 18,
                        width: 18,
                      ),
                      const Gap(6),
                      Text("Distance"),
                      const Gap(6),
                      Text("3.3 km", style: TextStyles.subTitle2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(4),
          _detailsTile("Start Time", "12:00 PM"),
          _detailsTile("End Time", "01:00 PM"),
        ],
      ),
    );
  }

  Widget _detailsTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        children: [
          Expanded(child: Text(title, style: TextStyles.body1, maxLines: 1)),
          const Gap(10),
          Text(
            value,
            style: TextStyles.subTitle2,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _earningsTile() {
    return BackgroundContainer(
      child: Column(
        children: const [
          _earningRow("Delivery Fee", "₹275"),
          _earningRow("Bonus", "₹20"),
          Divider(),
          _earningRow(
            "Total Earnings",
            "₹295",
            isBold: true,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  // Widget _customerRating() {
  //   return BackgroundContainer(child: Column(children: []));
  // }

  Widget _customerRating() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RatingScreen());
      },
      child: BackgroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                SvgPicture.asset(
                  AssetConst.rating,
                  height: 18,
                  width: 18,
                  // color: ColorConst.textPrimary,
                ),
                SvgPicture.asset(
                  AssetConst.star,
                  height: 18,
                  width: 18,
                  // color: ColorConst.textPrimary,
                ),
                const Gap(6),
                Text(
                  // Image.asset(
                  //   'assets/icons/rating.png',
                  //   height: 18,
                  //   width: 18,
                  // ),
                  // const Gap(6),
                  "Customer Rating",
                  style: TextStyles.subTitle1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
            const Gap(10),

            // Star Rating Row
            Row(
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Colors.amber, size: 22),
              ),
            ),
            const Gap(6),

            // Feedback Text
            Text(
              "Great job!",
              style: TextStyles.subTitle2.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _earningRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;
  final Color? color;

  const _earningRow(this.title, this.value, {this.isBold = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
