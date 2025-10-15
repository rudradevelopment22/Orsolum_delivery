import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/common/online_toggle.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/modules/home/home_controller.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_orders_screen.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/common/map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_order_controller.dart';

import '../../models/order_model.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key}) {
    // Initialize location services when the widget is created
    Get.find<HomeController>().determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return controller.isVerified.value
          ? _buildUnverifiedScreen()
          : _buildVerifiedScreen();
    });
  }

  /// Unverified User Screen
  Widget _buildUnverifiedScreen() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment(0.0, 0.3),
          // This makes the green cover about 30% from top
          stops: [0.4, 0.5], // This makes the transition smoother
        ),
      ),
      padding: EdgeInsets.only(right: 20, left: 20, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hi Ritesh Patel !!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const Gap(4),
          const Text(
            "Welcome to Orsolum family. You are almost done. Complete these so you can start getting orders.",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const Gap(20),

          /// Profile completion card
          // Background with green gradient
          Column(
            children: [
              // First Card - Pending
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorConst.neutralShade10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF4CAF50),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.circle,
                              size: 16,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Complete your nominee details, vehicle details and personal information.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                        const Gap(10),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Pending",
                              style: TextStyle(
                                color: Color(0xFFFFA000),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          // Navigate to profile completion
                        },
                        child: const Text(
                          "Complete profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Second Card - Completed
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorConst.neutralShade10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Your document have been approved and ID is activated.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Completed",
                        style: TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Verified User Screen
  Widget _buildVerifiedScreen() {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 16),
        centerTitle: false,
        backgroundColor: ColorConst.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.primaryShade30,
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.user.value.firstName.isNotEmpty
                      ? controller.user.value.firstName[0].toUpperCase()
                      : 'U',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConst.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.grey200,
            ),
            child: Icon(
              CupertinoIcons.question_circle,
              color: ColorConst.grey500,
            ),
          ),
          const Gap(10),
          OnlineToggle(),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello",
                style: TextStyles.subTitle2.copyWith(color: ColorConst.grey500),
              ),
              Obx(
                () => Text(
                  "${controller.user.value.firstName} ${controller.user.value.lastName}"
                      .trim(),
                  style: TextStyles.subTitle1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 4,
      ),
      backgroundColor: ColorConst.grey100,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(24),

              /// Earnings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.7, 0.9],
                      colors: [ColorConst.primaryShade10, ColorConst.white],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetConst.route,
                              colorFilter: ColorFilter.mode(
                                ColorConst.primary,
                                BlendMode.srcIn,
                              ),
                              height: 14,
                              width: 14,
                            ),
                            const Gap(4),
                            Text(
                              "Available for delivery",
                              style: TextStyles.captionBold,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              "Today's Earning",
                              "₹ 821",
                              AssetConst.coins,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: _buildInfoCard(
                              "Deliveries",
                              "5",
                              AssetConst.deliveryProtect,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),

              /// New Orders
              _buildNewOrdersSection(),

              const Gap(20),

              /// Ongoing Orders
              _buildOngoingOrdersSection(),

              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  /// User stats section
  Widget _buildUserStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConst.primaryShade10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // User avatar with initials
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.primaryShade30,
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.user.value.firstName.isNotEmpty
                      ? controller.user.value.firstName[0].toUpperCase()
                      : 'U',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConst.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // User details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "${controller.user.value.firstName} ${controller.user.value.lastName}"
                        .trim(),
                    style: TextStyles.subTitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    controller.user.value.phone,
                    style: TextStyles.body2.copyWith(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    "${controller.user.value.city}, ${controller.user.value.state}",
                    style: TextStyles.caption.copyWith(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// New orders section
  // Widget _buildNewOrdersSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //         child: Row(
  //           children: [
  //             Text(
  //               "New Orders",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             Spacer(),
  //             GestureDetector(
  //               onTap: () {
  //                 Get.put(NewOrderController()); // Initialize controller
  //                 Get.to(() => const NewOrdersScreen());
  //               },
  //               child: Text(
  //                 "See all Orders",
  //                 style: TextStyles.body2.copyWith(color: ColorConst.primary),
  //               ),
  //             ),
  //             const Gap(2),
  //             Icon(
  //               Icons.check_circle_outline,
  //               size: 16,
  //               color: ColorConst.primary,
  //             ),
  //           ],
  //         ),
  //       ),
  //       _buildNewOrderCard(),
  //     ],
  //   );
  // }

  /// New orders section
  Widget _buildNewOrdersSection() {
    final controller = Get.put(NewOrderController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Text(
                "New Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => const NewOrdersScreen());
                },
                child: Text(
                  "See all Orders",
                  style: TextStyle(fontSize: 14, color: Color(0xFF054FA3)),
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.check_circle_outline,
                size: 16,
                color: Color(0xFF054FA3),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.orders.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("No new orders"),
            );
          } else {
            return Column(
              children:
                  controller.orders
                      .expand(
                        (order) => order.data ?? [],
                      ) // flatten all inner data lists
                      .map((item) => _buildOrderCard(item))
                      .toList(),
            );

            //   Column(
            //   children:
            //
            //   controller.orders
            //       .map(
            //         (order) =>
            //         _buildOrderCard(controller.orders[0].data[]),
            //   )
            //       .toList(),
            // );
          }
        }),
      ],
    );
  }

  Widget _buildOrderCard(Datum order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.address?.name ?? "Unknown Customer",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text("Order ID: ${order.orderId ?? ""}"),
            const SizedBox(height: 4),
            Text("Pickup: ${order.address?.line1 ?? ""}"),
            Text("Delivery: ${order.address?.city ?? ""}"),
            const SizedBox(height: 4),
            Text(
              "Total: ₹${order.summary?.totalAmount?.toStringAsFixed(2) ?? "0.00"}",
            ),
          ],
        ),
      ),
    );
  }

  /// Ongoing orders section
  Widget _buildOngoingOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Ongoing Orders",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        // Add your ongoing orders list here
        // This is a placeholder - replace with actual order list
        _buildOngoingOrderCard(),
        // Container(
        //   margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        //   padding: const EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(12),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withValues(alpha: 0.1),
        //         spreadRadius: 1,
        //         blurRadius: 5,
        //         offset: const Offset(0, 2),
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     children: [
        //       const Icon(
        //         Icons.delivery_dining_outlined,
        //         size: 48,
        //         color: Colors.grey,
        //       ),
        //       const SizedBox(height: 8),
        //       const Text(
        //         "No ongoing deliveries",
        //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        //       ),
        //       const SizedBox(height: 8),
        //       Text(
        //         "Your active deliveries will appear here",
        //         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        //         textAlign: TextAlign.center,
        //       ),
        //       const SizedBox(height: 16),
        //       ElevatedButton(
        //         onPressed: () {
        //           // Refresh orders
        //           controller.refreshUserData();
        //         },
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: ColorConst.primary,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //           padding: const EdgeInsets.symmetric(
        //             horizontal: 24,
        //             vertical: 12,
        //           ),
        //         ),
        //         child: const Text(
        //           "Refresh",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  /// Reusable card for stats
  Widget _buildInfoCard(String title, String value, String icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(icon, height: 14, width: 14),
              const Gap(4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyles.button,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(value, style: TextStyles.headline6),
        ],
      ),
    );
  }

  // /// New Order card
  // Widget _buildNewOrderCard() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     child: BackgroundContainer(
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   color: Colors.blueAccent.withValues(alpha: 0.1),
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 8,
  //                   vertical: 6,
  //                 ),
  //                 child: Text(
  //                   "New",
  //                   style: TextStyle(color: Colors.blueAccent),
  //                 ),
  //               ),
  //               Column(
  //                 children: [
  //                   Text("John Doe", style: TextStyles.headline6),
  //                   Text("ORD-2024-001", style: TextStyles.subTitle2),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           const Gap(6),
  //           ListView.separated(
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) {
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       SvgPicture.asset(AssetConst.box, height: 16, width: 16),
  //                       const Gap(8),
  //                       Text(
  //                         "Powder Garden Mix Soil",
  //                         style: TextStyles.subTitle2,
  //                       ),
  //                     ],
  //                   ),
  //                   const Gap(4),
  //                   Row(children: [const Gap(24), Text("25Kg x 1")]),
  //                 ],
  //               );
  //             },
  //             separatorBuilder: (context, index) => const Gap(4),
  //             itemCount: 1,
  //             padding: EdgeInsets.zero,
  //           ),
  //           const Gap(10),
  //           Row(
  //             children: [
  //               SvgPicture.asset(AssetConst.bag, height: 16, width: 16),
  //               const Gap(8),
  //               Text("Shop No. 5, Paldi, Ahmedabad"),
  //             ],
  //           ),
  //           const Gap(6),
  //           Row(
  //             children: [
  //               SvgPicture.asset(AssetConst.location, height: 16, width: 16),
  //               const Gap(8),
  //               Text("12, Patel Nager, Surat - 395001"),
  //             ],
  //           ),
  //           const Gap(6),
  //           Row(
  //             children: [
  //               SvgPicture.asset(
  //                 AssetConst.clock,
  //                 colorFilter: ColorFilter.mode(
  //                   ColorConst.accentInfo,
  //                   BlendMode.srcIn,
  //                 ),
  //                 height: 16,
  //                 width: 16,
  //               ),
  //               const Gap(8),
  //               Text("30-40 mi"),
  //               const Gap(10),
  //               SvgPicture.asset(
  //                 AssetConst.route,
  //                 colorFilter: ColorFilter.mode(
  //                   ColorConst.accentInfo,
  //                   BlendMode.srcIn,
  //                 ),
  //                 height: 16,
  //                 width: 16,
  //               ),
  //               const Gap(8),
  //               Text("2.5 Km"),
  //             ],
  //           ),
  //           const Gap(14),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     // Ensure controller is available
  //                     final newOrderController =
  //                         Get.isRegistered<NewOrderController>()
  //                             ? Get.find<NewOrderController>()
  //                             : Get.put(NewOrderController());
  //                     // Call acceptOrders API with dynamic order id if available
  //                     final orderId =
  //                         newOrderController.orders.isNotEmpty
  //                             ? newOrderController.orders.first.id
  //                             : null;
  //                     if (orderId != null && orderId.isNotEmpty) {
  //                       newOrderController.acceptOrder(orderId);
  //                     } else {
  //                       Get.snackbar('No orders', 'No new orders to accept');
  //                     }
  //                   },
  //                   child: Container(
  //                     height: 42,
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                       color: ColorConst.primary,
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     alignment: Alignment.center,
  //                     child: Row(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Icon(
  //                           Icons.check_circle,
  //                           color: ColorConst.white,
  //                           size: 16,
  //                         ),
  //                         const Gap(4),
  //                         Text(
  //                           "Accept",
  //                           style: TextStyles.button.copyWith(
  //                             color: ColorConst.white,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const Gap(16),
  //               Expanded(
  //                 child: Container(
  //                   height: 42,
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     color: Colors.transparent,
  //                     border: Border.all(color: ColorConst.primary),
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Icon(
  //                         Icons.add_circle,
  //                         color: ColorConst.primary,
  //                         size: 16,
  //                       ),
  //                       const Gap(4),
  //                       Text("Skip", style: TextStyles.button),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Ongoing Order card
  Widget _buildOngoingOrderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConst.accentWarning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(6),
                child: SvgPicture.asset(
                  AssetConst.location,
                  colorFilter: ColorFilter.mode(
                    ColorConst.accentWarning,
                    BlendMode.srcIn,
                  ),
                  height: 24,
                  width: 24,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Delivery Location",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "20/D, Ananta Apts",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(12),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: MapWidget(
              markers: {
                Marker(
                  markerId: const MarkerId("home"),
                  position: LatLng(28.6139, 77.2090),
                  infoWindow: const InfoWindow(title: "Home"),
                ),
              },
              initialPosition: LatLng(28.6139, 77.2090),
            ),
          ),
          const Gap(12),
          CustomButton(
            text: "Navigation",
            onTap: () {
              Get.toNamed(RouterUtils.deliveryTracking);
            },
          ),
        ],
      ),
    );
  }

  // Bottom navigation has been moved to MainScreen
}
