import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:orsolum_delivery/common/map_widget.dart';
import 'package:orsolum_delivery/common/online_toggle.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'delivery_tracking_controller.dart';

class DeliveryTrackingScreen extends GetView<DeliveryTrackingController> {
  const DeliveryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Tracking"),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 16),
        actions: [OnlineToggle()],
      ),
      body: Stack(
        children: [
          // Map View
          _buildMapView(),

          // Bottom Sheet
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomSheet()),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Obx(
      () => MapWidget(
        initialPosition: controller.currentLocation.value,
        markers: _createMarkers(),
        polylines: _createPolylines(),
        onMapCreated: (GoogleMapController mapController) {
          // You can store the controller if needed
        },
        onCameraMove: (CameraPosition cameraPosition) {
          // Update current position if needed
          // controller.updateCurrentLocation(cameraPosition.target);
        },
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      // Current location marker
      Marker(
        markerId: const MarkerId('current_location'),
        position: controller.currentLocation.value,
        icon:
            controller.driverMarker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),

      // Store marker
      if (!controller.isPickedUp.value)
        Marker(
          markerId: const MarkerId('store_location'),
          position: controller.storeLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(title: controller.storeName),
        ),

      // Customer marker
      if (controller.isPickedUp.value)
        Marker(
          markerId: const MarkerId('customer_location'),
          position: controller.customerLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: controller.customerName),
        ),
    };
  }

  Set<Polyline> _createPolylines() {
    final polylineId =
        controller.isPickedUp.value ? 'route_to_customer' : 'route_to_store';

    if (controller.routePoints.isEmpty) {
      // Fallback to straight line if no route points are available
      final points =
          controller.isPickedUp.value
              ? [controller.currentLocation.value, controller.customerLocation]
              : [controller.currentLocation.value, controller.storeLocation];

      return {
        Polyline(
          polylineId: PolylineId(polylineId),
          color: Colors.blue,
          width: 5,
          points: points,
        ),
      };
    }

    // Use the route points from the Directions API
    return {
      Polyline(
        polylineId: PolylineId(polylineId),
        color: Colors.blue,
        width: 5,
        points: controller.routePoints,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
      ),
    };
  }

  Widget _buildBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        if (controller.isReached.value) {
          return _buildReachedLocationSheet();
        } else if (controller.isNavigating.value) {
          return _buildNavigatingSheet();
        } else if (controller.isPickedUp.value) {
          return _buildOrderDetailsSheet();
        } else {
          return _buildOnTheWayToStoreSheet();
        }
      }),
    );
  }

  Widget _buildOnTheWayToStoreSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConst.accentSuccess,
                ),
              ),
              const Gap(6),
              Expanded(
                child: Text(
                  'On the way to Store',
                  style: TextStyles.buttonLarge,
                ),
              ),
              const Gap(4),
              Icon(
                PhosphorIconsRegular.timer,
                color: ColorConst.accentInfo,
                size: 20,
              ),
              const Gap(6),
              Text(
                "19 min",
                style: TextStyles.button.copyWith(color: ColorConst.accentInfo),
              ),
            ],
          ),
        ),
        Divider(),
        Gap(10),
        _buildLocationCard(
          Icons.location_on_outlined,
          controller.storeName,
          controller.storeAddress,
        ),
        const SizedBox(height: 16),
        CustomButton(
          onTap: controller.markAsPickedUp,
          text: 'Order Picked',
          // isExpanded: true,
        ),
      ],
    );
  }

  Widget _buildOrderDetailsSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(PhosphorIconsRegular.package, size: 18),
              const Gap(6),
              Expanded(
                child: Text('Order #0192232', style: TextStyles.buttonLarge),
              ),
              const Gap(4),
              Icon(
                PhosphorIconsRegular.timer,
                color: ColorConst.accentInfo,
                size: 20,
              ),
              const Gap(6),
              Text(
                "19 min",
                style: TextStyles.button.copyWith(color: ColorConst.accentInfo),
              ),
            ],
          ),
        ),
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConst.grey100,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.centerLeft,
          child: Container(
            height: 12,
            width: double.infinity * 0.3,
            decoration: BoxDecoration(
              color: ColorConst.accentInfo,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text("On the way to Customer", style: TextStyles.buttonLarge),

        const Divider(height: 24, thickness: 1),
        _buildLocationSection(
          'Pickup from',
          Icons.location_on_outlined,
          controller.storeName,
          controller.storeAddress,
        ),
        const SizedBox(height: 16),
        _buildLocationSection(
          'Deliver to',
          Icons.home_outlined,
          controller.customerName,
          controller.customerAddress,
        ),
        const SizedBox(height: 16),
        CustomButton(
          onTap: () {
            Get.toNamed(
              RouterUtils.orderDetailsScreen,
              arguments: {
                'orderId': controller.orderId,
                // Add any other order details you want to pass
              },
            );
          },
          text: 'View Full Order Details',
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        ),
        const SizedBox(height: 12),
        CustomButton(
          onTap: controller.startNavigation,
          text: 'Start Navigating',
          // isExpanded: true,
        ),
      ],
    );
  }

  Widget _buildNavigatingSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConst.accentSuccess,
                ),
              ),
              const Gap(6),
              Expanded(
                child: Text(
                  'On the way to customer',
                  style: TextStyles.buttonLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(4),
              Icon(
                PhosphorIconsRegular.timer,
                color: ColorConst.accentInfo,
                size: 20,
              ),
              const Gap(6),
              Text(
                "19 min",
                style: TextStyles.button.copyWith(color: ColorConst.accentInfo),
              ),
            ],
          ),
        ),
        Divider(),
        Gap(10),
        _buildLocationCard(
          Icons.home_outlined,
          controller.customerName,
          controller.customerAddress,
        ),
        const SizedBox(height: 16),
        CustomButton(
          onTap: controller.markAsReached,
          text: 'Reached Location',
          // isExpanded: true,
        ),
      ],
    );
  }

  Widget _buildReachedLocationSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStepIndicator(4, 'You have reached at the location'),
        const SizedBox(height: 16),
        _buildLocationCard(
          Icons.home_outlined,
          controller.customerName,
          controller.customerAddress,
        ),
        const SizedBox(height: 16),
        _buildPaymentDetails(),
        const SizedBox(height: 16),
        CustomButton(
          onTap: controller.markAsDelivered,
          text: 'Order Delivered',
          // isExpanded: true,
        ),
      ],
    );
  }

  Widget _buildStepIndicator(int currentStep, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConst.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                currentStep.toString(),
                style: TextStyles.subTitle1Semibold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyles.headline6.copyWith(color: Colors.black),
                maxLines: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStepDot(1, currentStep >= 1),
            _buildStepLine(1, currentStep),
            _buildStepDot(2, currentStep >= 2),
            _buildStepLine(2, currentStep),
            _buildStepDot(3, currentStep >= 3),
            _buildStepLine(3, currentStep),
            _buildStepDot(4, currentStep >= 4),
          ],
        ),
      ],
    );
  }

  Widget _buildStepDot(int step, bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? ColorConst.primary : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildStepLine(int step, int currentStep) {
    return Container(
      width: 40,
      height: 2,
      color: step < currentStep ? ColorConst.primary : Colors.grey[300],
    );
  }

  Widget _buildLocationCard(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConst.accentInfo.withValues(alpha: 0.2),
          ),
          child: Icon(icon, color: ColorConst.accentInfo, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyles.subTitle1Semibold),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyles.body2.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Gap(10),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConst.primary.withValues(alpha: 0.2),
          ),
          child: Icon(
            PhosphorIconsRegular.phone,
            color: ColorConst.primary,
            size: 24,
          ),
        ),
        Gap(10),
        GestureDetector(
          onTap: () {
            Get.toNamed(RouterUtils.chat);
          },
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.primary.withValues(alpha: 0.2),
            ),
            child: Icon(
              PhosphorIconsRegular.chatText,
              color: ColorConst.primary,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(
    String label,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.caption.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        _buildLocationCard(icon, title, subtitle),
      ],
    );
  }

  Widget _buildOrderInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.body1.copyWith(color: Colors.grey[600])),
        Text(value, style: TextStyles.subTitle1Semibold),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildPaymentRow('Order Amount', controller.orderAmount),
          const SizedBox(height: 8),
          _buildPaymentRow('Delivery Fee', controller.deliveryFee),
          const Divider(height: 24, thickness: 1),
          _buildPaymentRow(
            'Total Amount',
            controller.totalAmount,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.body2.copyWith(
            color: Colors.grey[600],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyles.body2.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? ColorConst.primary : null,
          ),
        ),
      ],
    );
  }
}
