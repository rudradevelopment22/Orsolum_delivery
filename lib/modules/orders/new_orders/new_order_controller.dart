import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/models/order_model.dart';
import 'package:orsolum_delivery/services/socket_service.dart';
import 'package:orsolum_delivery/utils/logs_utils.dart';

import '../../../api/api_const.dart';

class NewOrderController extends GetxController {
  // Observable variables
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  // final RxList<Datum> orders = <Datum>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Socket service
  late SocketService _socketService;

  @override
  void onInit() {
    super.onInit();
    _initializeSocketService();
  }

  Future<void> _initializeSocketService() async {
    try {
      if (!Get.isRegistered<SocketService>()) {
        await SocketService.init();
      }
      _socketService = Get.find<SocketService>();
      _setupSocketListeners();
      _requestDeliveryTasks();
    } catch (e) {
      LogsUtils.error(
        "❌ [NEW ORDERS] Failed to initialize socket service\n"
        "Error: ${e.toString()}",
        name: "NewOrderController",
      );
      errorMessage.value = 'Failed to connect to server';
    }
  }

  void _setupSocketListeners() {
    // Listen for delivery tasks from socket
    _socketService.events.listen((event) {
      if (event['type'] == 'delivery_task') {
        _handleDeliveryTask(event['data']);
      }
    });
  }

  void _requestDeliveryTasks() {
    LogsUtils.info(
      "🔄 [NEW ORDERS] Requesting delivery tasks from socket",
      name: "NewOrderController",
    );
    _socketService.requestDeliveryTasks();
  }

  void _handleDeliveryTask(dynamic data) {
    try {
      LogsUtils.info(
        "📦 [NEW ORDERS] Received delivery task from socket\n"
        "Data: $data",
        name: "NewOrderController",
      );

      // Convert socket data to OrderModel
      if (data != null) {
        final order = OrderModel.fromJson(Map<String, dynamic>.from(data));
        orders.add(order);

        LogsUtils.info(
          "✅ [NEW ORDERS] Successfully added order: ${order.data![0].orderId}",
          name: "NewOrderController",
        );
      }
    } catch (e, stackTrace) {
      LogsUtils.error(
        "❌ [NEW ORDERS] Failed to process delivery task\n"
        "Error: ${e.toString()}",
        error: e,
        stackTrace: stackTrace,
        name: "NewOrderController",
      );
    }
  }

  // Request new orders from socket
  // Future<void> fetchNewOrders() async {
  //   LogsUtils.info(
  //     "🔄 [NEW ORDERS] Requesting new orders from socket",
  //     name: "NewOrderController",
  //   );
  //   _requestDeliveryTasks();
  // }
  void fetchNewOrders() async {
    try {
      isLoading.value = true;
      // final response = await Dio().get(
      //   ApiConst.localBaseUrl + ApiConst.newOrders,
      // );

      final response = await Dio().get(
        "http://localhost:5000/api/deliveryboy/new/orders/v1",
        options: Options(
          headers: {'Authorization': 'Bearer ${ApiConst.token}'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        orders.value = data.map((json) => OrderModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching new orders: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh orders
  Future<void> refreshOrders() async {
    LogsUtils.info(
      "🔄 [NEW ORDERS] Manual refresh triggered",
      name: "NewOrderController",
    );
    _requestDeliveryTasks();
  }

  // // Accept order
  // Future<void> acceptOrder(String orderId) async {
  //   try {
  //     LogsUtils.info(
  //       "✅ [NEW ORDERS] Accepting order: $orderId",
  //       name: "NewOrderController",
  //     );
  //
  //     // Call acceptOrders API with orderId
  //     final response = await Api.client.post<Map<String, dynamic>>(
  //       endPoint: ApiConst.acceptOrders,
  //       requestBody: {"orderId": orderId},
  //     );
  //
  //     LogsUtils.info(
  //       "📨 [NEW ORDERS] acceptOrders API response => success: ${response.success}, message: ${response.message}",
  //       name: "NewOrderController",
  //     );
  //
  //     // On success remove order locally
  //     orders.removeWhere((order) => order.id == orderId);
  //
  //     Get.snackbar('Success', 'Order accepted successfully');
  //   } catch (e, stackTrace) {
  //     LogsUtils.error(
  //       "❌ [NEW ORDERS] Failed to accept order $orderId\n"
  //       "Error: ${e.toString()}",
  //       error: e,
  //       stackTrace: stackTrace,
  //       name: "NewOrderController",
  //     );
  //
  //     Get.snackbar('Error', 'Failed to accept order: ${e.toString()}');
  //   }
  // }

  // Reject order
  Future<void> rejectOrder(String orderId) async {
    try {
      LogsUtils.info(
        "❌ [NEW ORDERS] Rejecting order: $orderId",
        name: "NewOrderController",
      );

      orders.removeWhere((order) => order.data![0].orderId == orderId);

      LogsUtils.info(
        "❌ [NEW ORDERS] Order $orderId rejected successfully",
        name: "NewOrderController",
      );

      Get.snackbar('Success', 'Order rejected');
    } catch (e, stackTrace) {
      LogsUtils.error(
        "❌ [NEW ORDERS] Failed to reject order $orderId\n"
        "Error: ${e.toString()}",
        error: e,
        stackTrace: stackTrace,
        name: "NewOrderController",
      );

      Get.snackbar('Error', 'Failed to reject order: ${e.toString()}');
    }
  }
}
