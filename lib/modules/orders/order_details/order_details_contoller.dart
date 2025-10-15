import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orsolum_delivery/api/api_const.dart';

class OrderDetailsController extends GetxController {
  var isExpanded = false.obs;
  var isLoading = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  /// 🚚 Pickup Order API Call
  Future<void> pickupOrder(String orderId) async {
    try {
      isLoading.value = true;

      final url = Uri.parse("${ApiConst.baseUrl}${ApiConst.pickupOrders}");
      final body = {"orderId": orderId};

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer ${yourAccessToken}",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Order picked up successfully");
        Get.toNamed("/deliveryTracking");
      } else {
        final resBody = jsonDecode(response.body);
        Get.snackbar("Error", resBody["message"] ?? "Pickup failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
