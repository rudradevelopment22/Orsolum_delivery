import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashCollectionController extends GetxController {
  RxDouble total = 1250.0.obs;

  RxList<Map<String, dynamic>> recentCollections =
      [
        {"name": "John Doe", "amount": 200, "date": "29-Aug-2025"},
        {"name": "Jane Smith", "amount": 350, "date": "28-Aug-2025"},
        {"name": "Alex Lee", "amount": 700, "date": "27-Aug-2025"},
      ].obs;
}
