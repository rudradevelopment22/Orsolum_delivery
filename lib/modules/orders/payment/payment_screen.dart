import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/modules/orders/payment/payment_controller.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment"), centerTitle: true),
      backgroundColor: ColorConst.screenBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Total Amount to Pay", style: TextStyles.subTitle1),
            const Gap(10),
            Obx(
              () => Text(
                "₹ ${controller.totalAmount.value.toStringAsFixed(0)}",
                style: TextStyles.headline4,
              ),
            ),
            const Gap(20),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(16),
            ),
            const Gap(20),
            Text("Scan to Pay"),
            const Gap(30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Other Payment Options", style: TextStyles.headline6),
            ),
            const Gap(10),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final option = controller.paymentOptions[index];
                return _otherPaymentOptionTile(option, controller);
              },
              separatorBuilder: (context, index) => Gap(10),
              itemCount: controller.paymentOptions.length,
            ),
            const Gap(20),
            Text(
              "Having Trouble? Contact Support",
              style: TextStyles.subTitle2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _otherPaymentOptionTile(
    PaymentOption option,
    PaymentController controller,
  ) {
    // Get the appropriate subtitle based on payment method
    String getPaymentSubtitle() {
      switch (option.id) {
        case 'credit_card':
          return 'Pay with Visa, Mastercard, or other cards';
        case 'bank_transfer':
          return 'Direct bank transfer from your account';
        case 'digital_wallet':
          return 'Pay using UPI, Paytm, or other wallets';
        default:
          return '';
      }
    }

    return GestureDetector(
      onTap: () {
        // Handle different payment methods
        switch (option.id) {
          case 'credit_card':
            // Navigate to card payment screen
            Get.toNamed(RouterUtils.completed);
            break;
          case 'bank_transfer':
            // Navigate to bank transfer screen
            Get.toNamed(RouterUtils.completed);
            break;
          case 'digital_wallet':
            // Navigate to digital wallet screen
            Get.toNamed(RouterUtils.completed);
            break;
        }
      },
      child: BackgroundContainer(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConst.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                option.iconPath,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  ColorConst.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: TextStyles.subTitle1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    getPaymentSubtitle(),
                    style: TextStyles.caption.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
