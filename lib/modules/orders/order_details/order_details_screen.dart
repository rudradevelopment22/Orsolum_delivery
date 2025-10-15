import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/common/map_widget.dart';
import 'package:orsolum_delivery/common/online_toggle.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/orders/order_details/order_details_contoller.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Details"),
        actions: [OnlineToggle()],
        actionsPadding: EdgeInsets.only(right: 10),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _orderIdSection(),
            const Gap(12),

            // Customer
            _infoTile(
              title: "Customer",
              value: "Harsh Saha",
              icon: CupertinoIcons.person,
              subtitle: "Expected in 30 mins",
              trailingIcon: PhosphorIconsRegular.phone,
            ),

            const Gap(12),

            // Pickup Location
            _locationTile(
              title: "Pickup Location",
              value: "Nikhita Stores, Andheri East",
              icon: AssetConst.shop,
            ),

            const Gap(12),

            // Delivery Location
            _locationTile(
              title: "Delivery Location",
              value: "201/D, Ananta Apts",
              icon: AssetConst.shop,
            ),
            const Gap(12),

            // Product Details
            _dropdownTile(
              title: "Product Details",
              children: [
                _productItem(
                  "Madhur Pure & Hygienic Sugar",
                  "1 Kg",
                  "₹100",
                  img: "https://via.placeholder.com/50",
                ),
                const Gap(8),
                _productItem(
                  "MAGGI 2-Minute Instant Noodles",
                  "1 Packet",
                  "₹80",
                  img: "https://via.placeholder.com/50",
                ),
              ],
            ),

            const Gap(12),

            // Earnings
            _earningsTile(),
            const Gap(20),

            CustomButton(
              text: "PickUp",
              onTap: () {
                final orderId = Get.arguments?['orderId'];
                if (orderId != null) {
                  controller.pickupOrder(orderId);
                } else {
                  Get.snackbar("Error", "Order ID not found");
                }
              },
            ),

            // CustomButton(
            //   text: "PickUp",
            //   onTap: () {
            //     Get.toNamed(RouterUtils.deliveryTracking);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _orderIdSection() {
    return BackgroundContainer(
      isBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order ID", style: TextStyles.subTitle1),
              Text(
                "#ORD-12345",
                style: TextStyles.subTitle2.copyWith(color: ColorConst.grey400),
              ),
            ],
          ),
          const Gap(4),
          Row(
            children: [
              Icon(Icons.access_time, color: ColorConst.grey400, size: 14),
              const Gap(5),
              Text("2:30 PM"),
            ],
          ),
        ],
      ),
    );
  }

  // Info tile widget
  Widget _infoTile({
    required String title,
    required String value,
    IconData? icon,
    String? subtitle,
    String? trailing,
    IconData? trailingIcon,
  }) {
    return BackgroundContainer(
      isBorder: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConst.accentSuccess.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.green),
            ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.subTitle1),
                Text(value, style: TextStyles.subTitle2),

                if (subtitle != null) ...[
                  const Gap(6),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: ColorConst.grey400,
                        size: 14,
                      ),
                      const Gap(5),
                      Text(
                        "Expected in 30 mins",
                        style: TextStyles.captionSemiBold,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          if (trailingIcon != null)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConst.accentSuccess.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(trailingIcon, color: Colors.green),
            ),
        ],
      ),
    );
  }

  // Location Tile
  Widget _locationTile({
    required String title,
    required String value,
    required String icon,
  }) {
    return BackgroundContainer(
      isBorder: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorConst.primaryShade5,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(icon, height: 18, width: 18),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(10),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MapWidget(
                    zoom: 15,
                    markers: {
                      Marker(
                        markerId: const MarkerId("order"),
                        position: LatLng(28.6139, 77.2090),
                        infoWindow: const InfoWindow(title: "order"),
                      ),
                    },
                    initialPosition: LatLng(28.6139, 77.2090),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown Tile with products
  Widget _dropdownTile({
    required String title,
    required List<Widget> children,
  }) {
    return Obx(
      () => Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.isExpanded.value = !controller.isExpanded.value;
            },
            child: BackgroundContainer(
              isBorder: true,
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.expand_more),
                ],
              ),
            ),
          ),
          if (controller.isExpanded.value) ...[
            const Gap(10),
            BackgroundContainer(
              isBorder: true,
              padding: const EdgeInsets.all(10),
              child: Column(children: [...children]),
            ),
          ],
        ],
      ),
    );
  }

  // Product Item
  Widget _productItem(
    String name,
    String qty,
    String price, {
    required String img,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConst.neutralShade95,
                ),
              ),
              const Gap(4),
              Text(
                qty,
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
              const Gap(4),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            img,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(color: ColorConst.grey100),
                child: Icon(PhosphorIconsFill.image),
              );
            },
          ),
        ),
      ],
    );
  }

  // Earnings Tile
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
}

// Earnings Row
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
