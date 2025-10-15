import 'dart:ui';

class OrderItem {
  final String name;
  final String qty;
  final String price;
  final String image;

  OrderItem({
    required this.name,
    required this.qty,
    required this.price,
    required this.image,
  });
}

class OrderHistory {
  final String orderId;
  final String status;
  final String date;
  final List<OrderItem> items;
  final String paymentMethod;
  final String totalAmount;
  final Color statusColor;

  OrderHistory({
    required this.orderId,
    required this.status,
    required this.date,
    required this.items,
    required this.paymentMethod,
    required this.totalAmount,
    required this.statusColor,
  });
}
