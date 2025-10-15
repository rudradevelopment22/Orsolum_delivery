import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/orders/rateing/rating_controller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());

    return Scaffold(
      backgroundColor: ColorConst.screenBg,
      appBar: AppBar(
        title: const Text(
          'Rate Customer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Details Card
            _customerDetailsCard(),
            const Gap(20),

            // Delivery Experience Rating
            _deliveryExperienceSection(controller),
            const Gap(20),

            // Select All That Apply Section
            _selectAllThatApplySection(controller),
            const Gap(20),

            // Additional Comments Section
            _additionalCommentsSection(controller),
            const Gap(30),

            // Submit Button
            CustomButton(
              text: "Submit",
              onTap: () => controller.submitRating(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customerDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AssetConst.credit,
                height: 18,
                width: 18,
                color: ColorConst.primary,
              ),
              const Gap(8),
              Text(
                "Customer Details",
                style: TextStyles.subTitle1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(12),
          _customerDetailRow(
            Icons.person_outline,
            "Customer Name",
            "Harsh Saha",
          ),
          _customerDetailRow(Icons.tag_outlined, "Order No", "Ord# 23121"),
          _customerDetailRow(
            Icons.access_time_outlined,
            "Delivery time",
            "2:30 PM",
          ),
          _customerDetailRow(
            Icons.location_on_outlined,
            "Location",
            "201/D, Ananta..",
          ),
        ],
      ),
    );
  }

  Widget _customerDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: ColorConst.primary),
          const Gap(12),
          Expanded(
            child: Text(
              label,
              style: TextStyles.body1.copyWith(color: Colors.grey[600]),
            ),
          ),
          Text(value, style: TextStyles.subTitle2),
        ],
      ),
    );
  }

  Widget _deliveryExperienceSection(RatingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How was your delivery experience",
          style: TextStyles.subTitle1.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(12),
        Obx(
          () => Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => controller.setRating(index + 1),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    index < controller.selectedRating.value
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _selectAllThatApplySection(RatingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select all that apply",
          style: TextStyles.subTitle1.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(12),
        _feedbackOption(
          controller: controller,
          isSelected: controller.customerPolite,
          onTap: controller.toggleCustomerPolite,
          text: "Customer was polite",
        ),
        const Gap(8),
        _feedbackOption(
          controller: controller,
          isSelected: controller.clearInstructions,
          onTap: controller.toggleClearInstructions,
          text: "Clear delivery instructions",
        ),
        const Gap(8),
        _feedbackOption(
          controller: controller,
          isSelected: controller.easyToLocate,
          onTap: controller.toggleEasyToLocate,
          text: "Easy to locate",
        ),
        const Gap(8),
        _feedbackOption(
          controller: controller,
          isSelected: controller.safeDeliveryArea,
          onTap: controller.toggleSafeDeliveryArea,
          text: "Safe delivery area",
        ),
      ],
    );
  }

  Widget _feedbackOption({
    required RatingController controller,
    required RxBool isSelected,
    required VoidCallback onTap,
    required String text,
  }) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected.value ? Colors.green : Colors.transparent,
                  border: Border.all(
                    color: isSelected.value ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child:
                    isSelected.value
                        ? const Icon(Icons.check, color: Colors.white, size: 14)
                        : null,
              ),
              const Gap(12),
              Expanded(child: Text(text, style: TextStyles.body1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _additionalCommentsSection(RatingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Comments",
          style: TextStyles.subTitle1.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Add additional comments (optional)",
              hintStyle: TextStyles.body1.copyWith(color: Colors.grey[400]),
              border: InputBorder.none,
            ),
            onChanged: controller.updateComments,
          ),
        ),
      ],
    );
  }
}





