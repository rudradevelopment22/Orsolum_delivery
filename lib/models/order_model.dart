class OrderModel {
  String id;
  String customerName;
  String orderId;
  String status;
  String pickupAddress;
  String deliveryAddress;
  String estimatedTime;
  double distance;
  List<OrderItem> items;
  double totalAmount;
  String paymentMethod;
  DateTime createdAt;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.orderId,
    required this.status,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.estimatedTime,
    required this.distance,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      customerName: json['customerName'] ?? '',
      orderId: json['orderId'] ?? '',
      status: json['status'] ?? 'pending',
      pickupAddress: json['pickupAddress'] ?? '',
      deliveryAddress: json['deliveryAddress'] ?? '',
      estimatedTime: json['estimatedTime'] ?? '',
      distance: (json['distance'] ?? 0.0).toDouble(),
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      paymentMethod: json['paymentMethod'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'customerName': customerName,
      'orderId': orderId,
      'status': status,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'estimatedTime': estimatedTime,
      'distance': distance,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class OrderItem {
  String name;
  String quantity;
  double price;
  String image;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }
}