import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class OnlineToggleController extends GetxController {
  RxBool isOnline = true.obs; // default ON
}

class OnlineToggle extends GetView<OnlineToggleController> {
  const OnlineToggle({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnlineToggleController());
    return Obx(() {
      return GestureDetector(
        onTap: () {
          // controller.isOnline.toggle();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 80,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: controller.isOnline.value ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment:
                controller.isOnline.value
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.isOnline.value ? "Online" : "Offline",
                style: TextStyles.caption.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    });
  }
}
