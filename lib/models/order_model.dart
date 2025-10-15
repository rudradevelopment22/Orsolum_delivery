// class OrderModel {
//   String id;
//   String customerName;
//   String orderId;
//   String status;
//   String pickupAddress;
//   String deliveryAddress;
//   String estimatedTime;
//   double distance;
//   List<OrderItem> items;
//   double totalAmount;
//   String paymentMethod;
//   DateTime createdAt;
//
//   OrderModel({
//     required this.id,
//     required this.customerName,
//     required this.orderId,
//     required this.status,
//     required this.pickupAddress,
//     required this.deliveryAddress,
//     required this.estimatedTime,
//     required this.distance,
//     required this.items,
//     required this.totalAmount,
//     required this.paymentMethod,
//     required this.createdAt,
//   });
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       id: json['_id'] ?? '',
//       customerName: json['customerName'] ?? '',
//       orderId: json['orderId'] ?? '',
//       status: json['status'] ?? 'pending',
//       pickupAddress: json['pickupAddress'] ?? '',
//       deliveryAddress: json['deliveryAddress'] ?? '',
//       estimatedTime: json['estimatedTime'] ?? '',
//       distance: (json['distance'] ?? 0.0).toDouble(),
//       items: (json['items'] as List<dynamic>?)
//           ?.map((item) => OrderItem.fromJson(item))
//           .toList() ?? [],
//       totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
//       paymentMethod: json['paymentMethod'] ?? '',
//       createdAt: json['createdAt'] != null
//           ? DateTime.parse(json['createdAt'])
//           : DateTime.now(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'customerName': customerName,
//       'orderId': orderId,
//       'status': status,
//       'pickupAddress': pickupAddress,
//       'deliveryAddress': deliveryAddress,
//       'estimatedTime': estimatedTime,
//       'distance': distance,
//       'items': items.map((item) => item.toJson()).toList(),
//       'totalAmount': totalAmount,
//       'paymentMethod': paymentMethod,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
//
// class OrderItem {
//   String name;
//   String quantity;
//   double price;
//   String image;
//
//   OrderItem({
//     required this.name,
//     required this.quantity,
//     required this.price,
//     required this.image,
//   });
//
//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       name: json['name'] ?? '',
//       quantity: json['quantity'] ?? '',
//       price: (json['price'] ?? 0.0).toDouble(),
//       image: json['image'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'quantity': quantity,
//       'price': price,
//       'image': image,
//     };
//   }
// }
// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  int? status;
  bool? success;

  // List<Datum>? data;
  List<Datum>? data;
  int? totalCount;

  OrderModel({this.status, this.success, this.data, this.totalCount});

  OrderModel copyWith({
    int? status,
    bool? success,
    List<Datum>? data,
    int? totalCount,
  }) => OrderModel(
    status: status ?? this.status,
    success: success ?? this.success,
    data: data ?? this.data,
    totalCount: totalCount ?? this.totalCount,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json["status"],
    success: json["success"],
    data:
        json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),

    // data = (json['data'] as List<dynamic>?)
    //     ?.map((e) => Datum.fromJson(e))
    //     .toList();
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Datum {
  Summary? summary;
  String? id;
  dynamic createdBy;
  dynamic storeId;
  String? cfOrderId;
  String? invoiceUrl;
  List<ProductDetail>? productDetails;
  Address? address;
  String? orderId;
  String? status;
  String? paymentStatus;
  dynamic assignedDeliveryBoy;
  List<String>? skippedBy;
  DateTime? estimatedDate;
  String? deliveryNotes;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? refund;

  Datum({
    this.summary,
    this.id,
    this.createdBy,
    this.storeId,
    this.cfOrderId,
    this.invoiceUrl,
    this.productDetails,
    this.address,
    this.orderId,
    this.status,
    this.paymentStatus,
    this.assignedDeliveryBoy,
    this.skippedBy,
    this.estimatedDate,
    this.deliveryNotes,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.refund,
  });

  Datum copyWith({
    Summary? summary,
    String? id,
    dynamic createdBy,
    dynamic storeId,
    String? cfOrderId,
    String? invoiceUrl,
    List<ProductDetail>? productDetails,
    Address? address,
    String? orderId,
    String? status,
    String? paymentStatus,
    dynamic assignedDeliveryBoy,
    List<String>? skippedBy,
    DateTime? estimatedDate,
    String? deliveryNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    bool? refund,
  }) => Datum(
    summary: summary ?? this.summary,
    id: id ?? this.id,
    createdBy: createdBy ?? this.createdBy,
    storeId: storeId ?? this.storeId,
    cfOrderId: cfOrderId ?? this.cfOrderId,
    invoiceUrl: invoiceUrl ?? this.invoiceUrl,
    productDetails: productDetails ?? this.productDetails,
    address: address ?? this.address,
    orderId: orderId ?? this.orderId,
    status: status ?? this.status,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    assignedDeliveryBoy: assignedDeliveryBoy ?? this.assignedDeliveryBoy,
    skippedBy: skippedBy ?? this.skippedBy,
    estimatedDate: estimatedDate ?? this.estimatedDate,
    deliveryNotes: deliveryNotes ?? this.deliveryNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
    refund: refund ?? this.refund,
  );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    // summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
    id: json["_id"],
    createdBy: json["createdBy"],
    storeId: json["storeId"],
    cfOrderId: json["cf_order_id"],
    invoiceUrl: json["invoiceUrl"],
    productDetails:
        json["productDetails"] == null
            ? []
            : List<ProductDetail>.from(
              json["productDetails"]!.map((x) => ProductDetail.fromJson(x)),
            ),
    // address: json["address"] == null ? null : Address.fromJson(json["address"]),
    address: json['address'] != null ? Address.fromJson(json['address']) : null,
    orderId: json["orderId"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    assignedDeliveryBoy: json["assignedDeliveryBoy"],
    skippedBy:
        json["skippedBy"] == null
            ? []
            : List<String>.from(json["skippedBy"]!.map((x) => x)),
    estimatedDate:
        json["estimatedDate"] == null
            ? null
            : DateTime.parse(json["estimatedDate"]),
    deliveryNotes: json["deliveryNotes"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    refund: json["refund"],
  );

  Map<String, dynamic> toJson() => {
    "summary": summary?.toJson(),
    "_id": id,
    "createdBy": createdBy,
    "storeId": storeId,
    "cf_order_id": cfOrderId,
    "invoiceUrl": invoiceUrl,
    "productDetails":
        productDetails == null
            ? []
            : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "address": address?.toJson(),
    "orderId": orderId,
    "status": status,
    "paymentStatus": paymentStatus,
    "assignedDeliveryBoy": assignedDeliveryBoy,
    "skippedBy":
        skippedBy == null ? [] : List<dynamic>.from(skippedBy!.map((x) => x)),
    "estimatedDate": estimatedDate?.toIso8601String(),
    "deliveryNotes": deliveryNotes,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "refund": refund,
  };
}

class Address {
  String? name;
  String? phone;
  String? line1;
  String? city;
  String? state;
  String? pincode;
  String? country;

  Address({
    this.name,
    this.phone,
    this.line1,
    this.city,
    this.state,
    this.pincode,
    this.country,
  });

  Address copyWith({
    String? name,
    String? phone,
    String? line1,
    String? city,
    String? state,
    String? pincode,
    String? country,
  }) => Address(
    name: name ?? this.name,
    phone: phone ?? this.phone,
    line1: line1 ?? this.line1,
    city: city ?? this.city,
    state: state ?? this.state,
    pincode: pincode ?? this.pincode,
    country: country ?? this.country,
  );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    name: json["name"],
    phone: json["phone"],
    line1: json["line1"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "line1": line1,
    "city": city,
    "state": state,
    "pincode": pincode,
    "country": country,
  };
}

class ProductDetail {
  String? id;
  dynamic productId;
  String? productName;
  int? mrp;
  int? productPrice;
  int? quantity;
  int? freeQuantity;
  List<dynamic>? appliedOffers;

  ProductDetail({
    this.id,
    this.productId,
    this.productName,
    this.mrp,
    this.productPrice,
    this.quantity,
    this.freeQuantity,
    this.appliedOffers,
  });

  ProductDetail copyWith({
    String? id,
    dynamic productId,
    String? productName,
    int? mrp,
    int? productPrice,
    int? quantity,
    int? freeQuantity,
    List<dynamic>? appliedOffers,
  }) => ProductDetail(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    mrp: mrp ?? this.mrp,
    productPrice: productPrice ?? this.productPrice,
    quantity: quantity ?? this.quantity,
    freeQuantity: freeQuantity ?? this.freeQuantity,
    appliedOffers: appliedOffers ?? this.appliedOffers,
  );

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["_id"],
    productId: json["productId"],
    productName: json["productName"],
    mrp: json["mrp"],
    productPrice: json["productPrice"],
    quantity: json["quantity"],
    freeQuantity: json["freeQuantity"],
    appliedOffers:
        json["appliedOffers"] == null
            ? []
            : List<dynamic>.from(json["appliedOffers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productId": productId,
    "productName": productName,
    "mrp": mrp,
    "productPrice": productPrice,
    "quantity": quantity,
    "freeQuantity": freeQuantity,
    "appliedOffers":
        appliedOffers == null
            ? []
            : List<dynamic>.from(appliedOffers!.map((x) => x)),
  };
}

class Summary {
  int? totalAmount;

  // double? totalAmount;
  int? discountAmount;
  int? shippingFee;
  int? donate;
  int? grandTotal;

  Summary({
    this.totalAmount,
    this.discountAmount,
    this.shippingFee,
    this.donate,
    this.grandTotal,
  });

  Summary copyWith({
    int? totalAmount,
    int? discountAmount,
    int? shippingFee,
    int? donate,
    int? grandTotal,
  }) => Summary(
    totalAmount: totalAmount ?? this.totalAmount,
    // totalAmount: (json['totalAmount'] as num?)?.toDouble(),
    discountAmount: discountAmount ?? this.discountAmount,
    shippingFee: shippingFee ?? this.shippingFee,
    donate: donate ?? this.donate,
    grandTotal: grandTotal ?? this.grandTotal,
  );

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalAmount: json["totalAmount"],
    discountAmount: json["discountAmount"],
    shippingFee: json["shippingFee"],
    donate: json["donate"],
    grandTotal: json["grandTotal"],
  );

  Map<String, dynamic> toJson() => {
    "totalAmount": totalAmount,
    "discountAmount": discountAmount,
    "shippingFee": shippingFee,
    "donate": donate,
    "grandTotal": grandTotal,
  };
}
