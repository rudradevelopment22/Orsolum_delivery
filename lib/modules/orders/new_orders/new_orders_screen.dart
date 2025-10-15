import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/online_toggle.dart';
import 'package:orsolum_delivery/common/order_widget.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_order_controller.dart';
import 'package:orsolum_delivery/models/order_model.dart';

class NewOrdersScreen extends GetView<NewOrderController> {
  const NewOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("New Orders"),
        actions: [OnlineToggle()],
        actionsPadding: EdgeInsets.only(right: 10),
        elevation: 1,
      ),

      // body: Padding(
      //       padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      //       child: ListView.separated(
      //         itemBuilder: (context, index) {
      //           return OrderWidget();
      //         },
      //         separatorBuilder: (context, index) => const Gap(10),
      //         itemCount: 3,
      //       ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                const Gap(16),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: () => controller.refreshOrders(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                const Gap(16),
                Text(
                  'No new orders available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const Gap(8),
                Text(
                  'New orders will appear here when available',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: () => controller.refreshOrders(),
                  child: Text('Refresh'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshOrders,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final order = controller.orders[0].data?[index];
                return _buildOrderCard(order!);
              },
              separatorBuilder: (context, index) => const Gap(10),
              itemCount: controller.orders.length,
            ),
          ),
        );
      }),
    );
  }

  // Widget _buildOrderCard(OrderModel order) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.1),
  //           spreadRadius: 1,
  //           blurRadius: 5,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //               decoration: BoxDecoration(
  //                 color: Colors.blue.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Text(
  //                 "New",
  //                 style: TextStyle(
  //                   color: Colors.blue,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   order.customerName,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   order.orderId,
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.grey[600],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         const Gap(12),
  //
  //         // Order items
  //         ...order.items.map((item) => Padding(
  //           padding: const EdgeInsets.only(bottom: 8),
  //           child: Row(
  //             children: [
  //               Icon(Icons.shopping_bag, size: 16, color: Colors.grey[600]),
  //               const Gap(8),
  //               Expanded(
  //                 child: Text(
  //                   item.name,
  //                   style: TextStyle(fontWeight: FontWeight.w500),
  //                 ),
  //               ),
  //               Text(
  //                 '${item.quantity}',
  //                 style: TextStyle(color: Colors.grey[600]),
  //               ),
  //             ],
  //           ),
  //         )),
  //
  //         const Gap(12),
  //
  //         // Pickup address
  //         Row(
  //           children: [
  //             Icon(Icons.store, size: 16, color: Colors.grey[600]),
  //             const Gap(8),
  //             Expanded(
  //               child: Text(
  //                 order.pickupAddress,
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const Gap(8),
  //
  //         // Delivery address
  //         Row(
  //           children: [
  //             Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
  //             const Gap(8),
  //             Expanded(
  //               child: Text(
  //                 order.deliveryAddress,
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const Gap(8),
  //
  //         // Time and distance
  //         Row(
  //           children: [
  //             Icon(Icons.access_time, size: 16, color: Colors.blue),
  //             const Gap(8),
  //             Text(
  //               order.estimatedTime,
  //               style: TextStyle(color: Colors.blue),
  //             ),
  //             const Gap(16),
  //             Icon(Icons.route, size: 16, color: Colors.blue),
  //             const Gap(8),
  //             Text(
  //               '${order.distance.toStringAsFixed(1)} km',
  //               style: TextStyle(color: Colors.blue),
  //             ),
  //           ],
  //         ),
  //
  //         const Gap(16),
  //
  //         // Action buttons
  //         Row(
  //           children: [
  //             Expanded(
  //               child: ElevatedButton(
  //                 onPressed: () => controller.acceptOrder(order.id),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.green,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.check_circle, size: 16, color: Colors.white),
  //                     const Gap(4),
  //                     Text(
  //                       'Accept',
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             const Gap(16),
  //             Expanded(
  //               child: OutlinedButton(
  //                 onPressed: () => controller.rejectOrder(order.id),
  //                 style: OutlinedButton.styleFrom(
  //                   side: BorderSide(color: Colors.red),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.close, size: 16, color: Colors.red),
  //                     const Gap(4),
  //                     Text(
  //                       'Reject',
  //                       style: TextStyle(color: Colors.red),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildOrderCard(Datum order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    order.address?.name ?? "Unknown",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.orderId ?? "",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Product items
          if (order.productDetails != null)
            ...order.productDetails!.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.shopping_bag, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.productName ?? "",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '${item.quantity ?? 0}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 12),

          // Pickup & Delivery
          Row(
            children: [
              Icon(Icons.store, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  order.address?.line1 ?? "",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  order.address?.city ?? "",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Time & Actions
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                order.estimatedDate != null ? "${order.estimatedDate}" : "N/A",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
