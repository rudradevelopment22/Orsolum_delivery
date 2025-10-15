import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orsolum_delivery/api/api.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/models/home_res_model.dart';
import 'package:orsolum_delivery/models/user_model.dart';
import 'package:orsolum_delivery/services/socket_service.dart';
import 'package:orsolum_delivery/utils/storage_utils.dart';

import '../../models/order_model.dart';

class HomeController extends GetxController {
  // User data
  final Rx<User> user = User().obs;

  // Loading states
  // final RxBool isLoading = true.obs;
  var isLoading = false.obs;
  final RxBool isVerified = false.obs;

  // Location related
  final Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  final RxBool locationServiceEnabled = false.obs;
  final RxBool isOnline = false.obs;
  final _storage = StorageUtils.instance;

  final RxList<dynamic> socketEvents =
      <dynamic>[].obs; // To store socket events
  // var orders = <OrderModel>[].obs;
  var orders = <Datum?>[].obs;

  // Home data
  final Rx<ApiRes<HomeResModel>> rxApiGetHomeDetails = Rx(ApiRes.loading());

  // Current active order
  final Rx<Map<String, dynamic>?> currentOrder = Rx<Map<String, dynamic>?>(
    null,
  );

  // Listen for delivery task updates from socket
  void _listenForDeliveryTasks() {
    ever(_socketService.currentDeliveryTask, (task) {
      if (task != null) {
        currentOrder.value = task;
        print('🔄 [HOME] Updated current order from socket');
      }
    });
  }

  // Accept the current order
  void acceptOrder() {
    if (currentOrder.value != null) {
      // Emit event to server that order is accepted
      _socketService.socket?.emit('acceptDeliveryTask', {
        'taskId': currentOrder.value!['_id'],
        'status': 'accepted',
      });
      print('✅ [HOME] Order ${currentOrder.value!['_id']} accepted');
    }
  }

  // Reject the current order
  void rejectOrder() {
    if (currentOrder.value != null) {
      // Emit event to server that order is rejected
      _socketService.socket?.emit('rejectDeliveryTask', {
        'taskId': currentOrder.value!['_id'],
        'status': 'rejected',
      });
      print('❌ [HOME] Order ${currentOrder.value!['_id']} rejected');
      currentOrder.value = null; // Clear the current order
    }
  }

  // Check and request location permissions
  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    locationServiceEnabled.value = serviceEnabled;

    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  // Get current position
  Future<void> determinePosition() async {
    try {
      final hasPermission = await _checkLocationPermission();

      if (!hasPermission) {
        // Handle the case where user denied the permission
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      // Handle error
      debugPrint('Error getting location: $e');
    }
  }

  // Socket service instance
  final SocketService _socketService = Get.find<SocketService>();
  late final StreamSubscription _socketSubscription;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    _initSocketConnection();
    _listenForDeliveryTasks();
    fetchNewOrders();
  }

  // Initialize socket connection
  void _initSocketConnection() {
    try {
      // Set up connection status listener
      ever<bool>(_socketService.rxIsConnected, _handleConnectionChange);

      // Set up initial connection status
      _handleConnectionChange(_socketService.isConnected);

      // Listen to socket events
      _setupSocketListeners();

      print('✅ [HOME] Socket service initialized');
    } catch (e) {
      print('❌ [HOME] Error initializing socket service: $e');
    }
  }

  // Handle socket connection changes
  void _handleConnectionChange(bool connected) {
    if (connected) {
      print('🔄 [HOME] Socket connected, requesting delivery tasks...');
      setOnlineStatus(true);
      // Request delivery tasks when connected
      requestDeliveryTasks();
    } else {
      print('⚠️ [HOME] Socket disconnected');
      setOnlineStatus(false);
    }
  }

  // Set up socket event listeners
  void _setupSocketListeners() {
    _socketSubscription = _socketService.events.listen((event) {
      final eventType = event['type'] as String;
      final data = event['data'];

      switch (eventType) {
        case 'delivery_task':
          _handleNewDeliveryTask(data);
          break;
        case 'connected':
          _handleSocketConnected();
          break;
        // Add more event types as needed
      }
    });
  }

  void _handleNewDeliveryTask(dynamic data) {
    print('New delivery task received: $data');
    // Add to socket events list
    socketEvents.add({
      'type': 'new_delivery',
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Show notification
    Get.snackbar(
      'New Delivery Task',
      'You have a new delivery assignment',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleSocketConnected() {
    // The SocketService will handle requesting delivery tasks
    // No need to call it here as it's now handled automatically
    print('✅ [SOCKET] Socket connected, waiting for delivery tasks...');
  }

  @override
  void onClose() {
    // Cancel socket subscription
    _socketSubscription.cancel();

    // Add any other cleanup logic here

    super.onClose();
  }

  // Toggle online status
  void toggleOnlineStatus(bool value) {
    isOnline.value = value;

    if (value) {
      // If going online, ensure socket is connected
      _socketService.reconnect();
    } else {
      // If going offline, disconnect socket
      _socketService.disconnect();
    }

    // Store the online status preference
    _storage.write(key: 'isOnline', value: value.toString());

    // Update online status on server
    _socketService.setOnlineStatus(value);
  }

  // Set online status
  void setOnlineStatus(bool status) {
    isOnline.value = status;
    _storage.write(key: 'isOnline', value: status.toString());
  }

  // Load user data from secure storage
  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      final userData = await _storage.getUser();
      if (userData != null) {
        user.value = userData;
        print("this: ${userData.isVerified}");
        isVerified.value = userData.isVerified;

        // Load saved online status
        final savedStatus = await _storage.read(key: 'isOnline');
        if (savedStatus != null) {
          isOnline.value = savedStatus.toLowerCase() == 'true';
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh user data
  Future<void> refreshUserData() async {
    // Here you can add API call to refresh user data if needed
    await loadUserData();
  }

  // Request delivery tasks from server with error handling
  void requestDeliveryTasks() {
    try {
      _socketService.requestDeliveryTasks();
    } catch (e) {
      print('❌ [SOCKET] Error requesting delivery tasks: $e');
    }
  }

  Future<void> fetchNewOrders() async {
    try {
      isLoading.value = true;
      // final response = await Dio().get(ApiConst.localBaseUrl + ApiConst.newOrders);

      final response = await Dio().get(
        "http://localhost:5000/api/deliveryboy/new/orders/v1",
        options: Options(
          headers: {'Authorization': 'Bearer ${ApiConst.token}'},
        ),
      );
      log("data: : :: : :: : : ::  ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        orders.value =
            (response.data['data'] as List)
                .map((e) => Datum.fromJson(e))
                .toList();
      } else {
        orders.clear();
      }
    } catch (e) {
      print("Error fetching new orders: $e");
      orders.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
