import 'dart:io';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';

import 'enum.dart';

extension SizeConfig on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * Get.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * Get.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (Get.width / 3) / 100;
}

extension StringExtension on String {
  MessageType get messageType {
    switch (this) {
      case "text":
        return MessageType.text;
      case "image":
        return MessageType.image;
      case "video":
        return MessageType.video;
      case "gif":
        return MessageType.gif;
      default:
        return MessageType.text;
    }
  }

  Role get roleEnum {
    switch (this) {
      case "user":
        return Role.user;
      default:
        return Role.retailer;
    }
  }

  OrderStatus get orderStatus {
    switch (this) {
      case "Pending":
        return OrderStatus.pending;
      case "Accepted":
        return OrderStatus.accepted;
      case "Rejected":
        return OrderStatus.rejected;
      case "Product shipped":
        return OrderStatus.productShipped;
      case "On the way":
        return OrderStatus.onTheWay;
      case "Your Destination":
        return OrderStatus.yourDestination;
      case "Delivered":
        return OrderStatus.delivered;
      case "Cancelled":
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  ReturnStatus get returnStatus {
    switch (this) {
      case "Pending":
        return ReturnStatus.pending;
      case "Approved":
        return ReturnStatus.approved;
      case "Rejected":
        return ReturnStatus.rejected;
      case "PickedUp":
        return ReturnStatus.pickedUp;
      case "success":
        return ReturnStatus.success;
      case "Cancelled":
        return ReturnStatus.cancelled;
      default:
        return ReturnStatus.pending;
    }
  }
}

extension RoleExtension on Role {
  String get roleText {
    switch (this) {
      case Role.user:
        return "user";
      default:
        return "retailer";
    }
  }
}

extension FileExtensions on File {
  String get filename => path.split(Platform.pathSeparator).last;
}

extension DynamicExtension on dynamic {
  String get formatPrice {
    return NumberFormat.decimalPatternDigits(
      locale: 'en_in',
      decimalDigits: 0,
    ).format(this);
  }

  num convertDynamicToNum(dynamic value) {
    if (value is String) {
      return num.parse(value);
    } else {
      return value;
    }
  }
}

extension OrderStatusExtension on OrderStatus {
  String get statusText {
    switch (this) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.accepted:
        return "Accepted";
      case OrderStatus.rejected:
        return "Rejected";
      case OrderStatus.productShipped:
        return "Product shipped";
      case OrderStatus.onTheWay:
        return "On the way";
      case OrderStatus.yourDestination:
        return "Your Destination";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancelled:
        return "Cancelled";
      default:
        return "Pending";
    }
  }

  Color get lightColor {
    switch (this) {
      case OrderStatus.pending:
        return const Color(0xFFFBEEEE);
      case OrderStatus.accepted:
        return const Color(0xFFDBEBE2);
      case OrderStatus.rejected:
        return const Color(0xFFFBEEEE);
      case OrderStatus.productShipped:
        return const Color(0xFFDBEBE2);
      case OrderStatus.onTheWay:
        return const Color(0xFFF1F3FE);
      case OrderStatus.yourDestination:
        return const Color(0xFFFBEEEE);
      case OrderStatus.delivered:
        return const Color(0xFFDBEBE2);
      case OrderStatus.cancelled:
        return const Color(0xFFFBEEEE);
      default:
        return Colors.transparent;
    }
  }

  // String get asset {
  //   switch (this) {
  //     case OrderStatus.pending:
  //       return AssetConst.onTheWay;
  //     case OrderStatus.accepted:
  //       return AssetConst.deliveredOrder;
  //     case OrderStatus.rejected:
  //       return AssetConst.cancelOrder;
  //     case OrderStatus.onTheWay:
  //       return AssetConst.truck;
  //     case OrderStatus.delivered:
  //       return AssetConst.deliveredOrder;
  //     case OrderStatus.cancelled:
  //       return AssetConst.cancelOrder;
  //     default:
  //       return AssetConst.truck;
  //   }
  // }

  Color get darkColor {
    switch (this) {
      case OrderStatus.pending:
        return ColorConst.accentDanger;
      case OrderStatus.accepted:
        return ColorConst.accentSuccess;
      case OrderStatus.rejected:
        return ColorConst.accentDanger;
      case OrderStatus.productShipped:
        return ColorConst.accentSuccess;
      case OrderStatus.onTheWay:
        return ColorConst.accentInfo;
      case OrderStatus.yourDestination:
        return ColorConst.accentSuccess;
      case OrderStatus.delivered:
        return ColorConst.accentSuccess;
      case OrderStatus.cancelled:
        return ColorConst.accentDanger;
      default:
        return Colors.transparent;
    }
  }
}

extension ReturnStatusExtension on ReturnStatus {
  String get statusText {
    switch (this) {
      case ReturnStatus.pending:
        return "Pending";
      case ReturnStatus.approved:
        return "Approved";
      case ReturnStatus.rejected:
        return "Rejected";
      case ReturnStatus.pickedUp:
        return "Picked Up";
      case ReturnStatus.success:
        return "Success";
      case ReturnStatus.cancelled:
        return "Cancelled";
      default:
        return "Pending";
    }
  }

  Color get lightColor {
    switch (this) {
      case ReturnStatus.pending:
        return const Color(0xFFF1F3FE);
      case ReturnStatus.approved:
        return const Color(0xFFDBEBE2);
      case ReturnStatus.rejected:
        return const Color(0xFFFBEEEE);
      case ReturnStatus.pickedUp:
        return const Color(0xFFF1F3FE);
      case ReturnStatus.success:
        return const Color(0xFFDBEBE2);
      case ReturnStatus.cancelled:
        return const Color(0xFFFBEEEE);
      default:
        return Colors.transparent;
    }
  }

  // String get asset {
  //   switch (this) {
  //     case ReturnStatus.pending:
  //       return AssetConst.onTheWay;
  //     case ReturnStatus.approved:
  //       return AssetConst.deliveredOrder;
  //     case ReturnStatus.rejected:
  //       return AssetConst.cancelOrder;
  //     case ReturnStatus.pickedUp:
  //       return AssetConst.truck;
  //     case ReturnStatus.success:
  //       return AssetConst.deliveredOrder;
  //     case ReturnStatus.cancelled:
  //       return AssetConst.cancelOrder;
  //     default:
  //       return AssetConst.truck;
  //   }
  // }

  Color get darkColor {
    switch (this) {
      case ReturnStatus.pending:
        return ColorConst.accentInfo;
      case ReturnStatus.approved:
        return ColorConst.accentSuccess;
      case ReturnStatus.rejected:
        return ColorConst.accentDanger;
      case ReturnStatus.pickedUp:
        return ColorConst.accentInfo;
      case ReturnStatus.success:
        return ColorConst.accentSuccess;
      case ReturnStatus.cancelled:
        return ColorConst.accentDanger;
      default:
        return Colors.transparent;
    }
  }
}
