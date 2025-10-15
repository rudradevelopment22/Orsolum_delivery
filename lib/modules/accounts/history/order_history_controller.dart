import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/modules/accounts/history/order_history_model.dart';

enum OrderFilter { all, pending, completed, cancelled }

class OrderHistoryController extends GetxController {
  final Rx<OrderFilter> selectedFilter = OrderFilter.all.obs;
  final RxList<OrderHistory> allOrders = <OrderHistory>[].obs;
  final RxList<OrderHistory> filteredOrders = <OrderHistory>[].obs;
  RxString status = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadOrders();
  }

  void _loadOrders() {
    // Sample data
    allOrders.assignAll([
      OrderHistory(
        orderId: '#ORD-12345',
        status: 'Completed',
        date: '12 Sep 2023, 10:30 AM',
        items: [
          OrderItem(
            name: 'Margherita Pizza',
            qty: '1 x Large',
            price: '₹499',
            image: 'https://example.com/pizza.jpg',
          ),
          OrderItem(
            name: 'Garlic Bread',
            qty: '2 x Regular',
            price: '₹180',
            image: 'https://example.com/garlic-bread.jpg',
          ),
        ],
        paymentMethod: 'Credit Card',
        totalAmount: '₹679',
        statusColor: ColorConst.accentSuccess,
      ),
      OrderHistory(
        orderId: '#ORD-12344',
        status: 'Pending',
        date: '11 Sep 2023, 08:15 PM',
        items: [
          OrderItem(
            name: 'Veg Burger',
            qty: '1 x Combo',
            price: '₹199',
            image: 'https://example.com/burger.jpg',
          ),
        ],
        paymentMethod: 'UPI',
        totalAmount: '₹199',
        statusColor: ColorConst.accentWarning,
      ),
      OrderHistory(
        orderId: '#ORD-12343',
        status: 'Cancelled',
        date: '10 Sep 2023, 02:45 PM',
        items: [
          OrderItem(
            name: 'Pasta Alfredo',
            qty: '1 x Regular',
            price: '₹249',
            image: 'https://example.com/pasta.jpg',
          ),
          OrderItem(
            name: 'Garlic Bread',
            qty: '1 x Regular',
            price: '₹90',
            image: 'https://example.com/garlic-bread.jpg',
          ),
        ],
        paymentMethod: 'Debit Card',
        totalAmount: '₹339',
        statusColor: ColorConst.accentDanger,
      ),
    ]);

    filterOrders();
  }

  void setFilter(OrderFilter filter) {
    selectedFilter.value = filter;
    filterOrders();
  }

  void filterOrders() {
    if (selectedFilter.value == OrderFilter.all) {
      filteredOrders.assignAll(allOrders);
    } else {
      final status =
          selectedFilter.value.toString().split('.').last.toLowerCase();
      filteredOrders.assignAll(
        allOrders
            .where((order) => order.status.toLowerCase() == status)
            .toList(),
      );
    }
  }
}
