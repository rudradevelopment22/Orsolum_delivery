import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/modules/accounts/history/order_history_controller.dart';
import 'package:orsolum_delivery/modules/accounts/history/order_history_model.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OrderHistoryScreen extends GetView<OrderHistoryController> {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryController>(
      init: OrderHistoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Order History", style: TextStyles.headline6),
            centerTitle: true,
          ),
          backgroundColor: ColorConst.screenBg,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter Chips
                Obx(
                  () => Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .05),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _buildFilterChip(
                          "All",
                          controller.selectedFilter.value == OrderFilter.all,
                          ColorConst.primary,
                          onTap: () => controller.setFilter(OrderFilter.all),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          "Pending",
                          controller.selectedFilter.value ==
                              OrderFilter.pending,
                          ColorConst.accentWarning,
                          onTap:
                              () => controller.setFilter(OrderFilter.pending),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          "Completed",
                          controller.selectedFilter.value ==
                              OrderFilter.completed,
                          ColorConst.accentSuccess,
                          onTap:
                              () => controller.setFilter(OrderFilter.completed),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          "Cancelled",
                          controller.selectedFilter.value ==
                              OrderFilter.cancelled,
                          ColorConst.accentDanger,
                          onTap:
                              () => controller.setFilter(OrderFilter.cancelled),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(20),

                // Order List
                Obx(
                  () => Expanded(
                    child:
                        controller.filteredOrders.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    PhosphorIconsRegular.phosphorLogo,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No orders found',
                                    style: TextStyles.subTitle1.copyWith(
                                      color: ColorConst.neutralShade95,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'You don\'t have any ${controller.selectedFilter.value == OrderFilter.all ? '' : controller.selectedFilter.value.toString().split('.').first.toLowerCase()} orders yet',
                                    style: TextStyles.caption.copyWith(
                                      color: ColorConst.neutralShade60,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              itemCount: controller.filteredOrders.length,
                              itemBuilder: (context, index) {
                                final order = controller.filteredOrders[index];
                                return OrderCard(
                                  orderId: order.orderId,
                                  status: order.status,
                                  date: order.date,
                                  items: order.items,
                                  paymentMethod: order.paymentMethod,
                                  totalAmount: order.totalAmount,
                                  statusColor: order.statusColor,
                                );
                              },
                            ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    String text,
    bool selected,
    Color color, {
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? ColorConst.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? color : ColorConst.neutralShade95,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final Color statusColor;
  final List<OrderItem> items;
  final String paymentMethod;
  final String totalAmount;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.items,
    required this.paymentMethod,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  orderId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: ColorConst.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Gap(12),

          // Items
          for (var item in items) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorConst.neutralShade95,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        item.qty,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const Gap(2),
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80,
                        width: 80,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.error, color: Colors.red),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Gap(12),
          ],

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Method"),
                  const Gap(4),
                  Text(paymentMethod, style: TextStyles.buttonLarge),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Total Amount"),
                  Text(totalAmount, style: TextStyles.buttonLarge),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
