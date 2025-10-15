import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The navigation is now handled by the SplashController
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          AssetConst.splash,
          fit: BoxFit.cover,
          // Add error builder for better error handling
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Text('Error loading splash image'),
          ),
        ),
      ),
    );
  }
}
