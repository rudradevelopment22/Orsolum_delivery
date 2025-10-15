import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/services/directions_service.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

class DeliveryTrackingController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxBool isPickedUp = false.obs;
  final RxBool isDelivered = false.obs;
  final RxBool isNavigating = false.obs;
  final RxBool isReached = false.obs;
  final RxBool isLoadingRoute = false.obs;
  final RxList<LatLng> routePoints = <LatLng>[].obs;

  // Google Maps API Key - Make sure to add your API key here
  final DirectionsService _directionsService = DirectionsService(
    apiKey: ApiConst.googleApiKey, // Replace with your actual API key
  );

  // Sample data - replace with actual data from your API
  final storeLocation = const LatLng(19.0750, 72.8777); // Mumbai coordinates
  final customerLocation = const LatLng(19.0760, 72.8877); // Nearby coordinates
  final currentLocation = const LatLng(19.0780, 72.8777).obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial route when controller initializes
    _loadCustomMarkers();
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    try {
      isLoadingRoute.value = true;
      final origin = currentLocation.value;
      final destination = isPickedUp.value ? customerLocation : storeLocation;

      final response = await _directionsService.getDirections(
        origin,
        destination,
      );

      if (response != null && response['status'] == 'OK') {
        final points = response['routes'][0]['overview_polyline']['points'];
        routePoints.value = DirectionsService.decodePolyline(points);
      }
    } catch (e) {
      print('Error fetching route: $e');
    } finally {
      isLoadingRoute.value = false;
    }
  }

  // Sample order details
  final orderId = 'ORD-123456';
  final storeName = 'Orsolum Store';
  final storeAddress = '123 Business Street, Mumbai';
  final customerName = 'Rahul Sharma';
  final customerAddress = '456 Residential Area, Mumbai';
  final orderAmount = '₹450.00';
  final deliveryFee = '₹50.00';
  final totalAmount = '₹500.00';

  BitmapDescriptor? storeMarker;
  BitmapDescriptor? customerMarker;
  BitmapDescriptor? driverMarker;

  void _loadCustomMarkers() async {
    storeMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/store_marker.png',
    );

    customerMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/customer_marker.png',
    );

    driverMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(80, 80)),
      AssetConst.driver,
    );
  }

  // Update current location (to be called from map updates)
  void updateCurrentLocation(LatLng newLocation) {
    currentLocation.value = newLocation;
  }

  // Mark order as picked up
  void markAsPickedUp() {
    isPickedUp.value = true;
    currentStep.value = 1;
    fetchRoute(); // Fetch new route to customer
  }

  // Start navigation to customer
  void startNavigation() {
    isNavigating.value = true;
    currentStep.value = 2;
    fetchRoute(); // Refresh the route
  }

  // Mark as reached customer location
  void markAsReached() {
    isReached.value = true;
    currentStep.value = 3;
  }

  // Mark order as delivered
  void markAsDelivered() {
    isDelivered.value = true;
    // Navigate back to home or order completion screen
    Get.toNamed(RouterUtils.payment);
  }
}
