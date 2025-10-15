import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Get.back(),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade200,
          //     blurRadius: 8,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
      ),
    );
  }
}
