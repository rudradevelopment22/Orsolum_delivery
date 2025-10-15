import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class User {
  String id = "";
  String firstName = "";
  String lastName = "";
  String state = "";
  String city = "";
  String phone = "";
  String image = "";
  String? email = "";
  DateTime? dob;
  String token = "";
  String expiryDate = "";
  num cardNumber = 0;
  int coins = 0;
  bool isActive = false;
  bool isVerified = false;

  String get subscriptionEndDate {
    try {
      return DateFormat(
        "dd MMMM yyyy",
      ).format(DateTime.parse(expiryDate).toLocal());
    } catch (e) {
      return "";
    }
  }

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    state = json['state'] ?? "";
    dob = json['dob'] != null ? DateTime.parse(json['dob']) : null;
    email = json['email'] ?? "";
    // role = ((json['role'] ?? "") as String).roleEnum;
    city = json['city'] ?? "";
    phone = json['phone'] ?? "";
    image = json['image'] ?? "";
    token = json["token"] ?? "";
    coins = json["coins"] ?? 0;
    expiryDate = json["expiryDate"] ?? "";
    cardNumber = json["cardNumber"] ?? 0;
    isActive = json["isActive"] ?? false;
    isVerified = json["isVerified"] ?? false;
  }

  User.fromString(String str) {
    final json = jsonDecode(str);
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    state = json['state'] ?? "";
    email = json['email'] ?? "";
    dob = json['dob'] != null ? DateTime.parse(json['dob']) : null;
    // role = ((json['role'] ?? "") as String).roleEnum;
    city = json['city'] ?? "";
    phone = json['phone'] ?? "";
    image = json['image'] ?? "";
    token = json["token"] ?? "";
    coins = json["coins"] ?? 0;
    expiryDate = json["expiryDate"] ?? "";
    cardNumber = json["cardNumber"] ?? 0;
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'state': state,
    'dob': dob?.toIso8601String(),
    'email': email,
    // 'role': role.roleText,
    'city': city,
    'phone': phone,
    'image': image,
    'coins': coins,
    'token': token,
    'cardNumber': cardNumber,
    'expiryDate': expiryDate,
    'isActive': isActive,
    'isVerified': isVerified,
  };

  @override
  String toString() => jsonEncode(toJson());
}
