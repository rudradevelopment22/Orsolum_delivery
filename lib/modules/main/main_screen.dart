import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/modules/accounts/account_page/accounts_screen.dart';
import 'package:orsolum_delivery/modules/earnings/earnings_summary_page.dart';
import 'package:orsolum_delivery/modules/home/home_screen.dart';
import 'package:orsolum_delivery/modules/main/main_controller.dart';
import 'package:orsolum_delivery/modules/notification/notification_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key}) {
    // Initialize the controller
    Get.put(MainController());
  }

  final List<Widget> _screens = [
    HomePage(),
    NotificationsPage(),
    EarningsSummaryPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: const Icon(Icons.home_outlined, size: 24),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home, size: 24, color: ColorConst.primary),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: const Icon(Icons.notifications_none_outlined, size: 24),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.notifications,
                  size: 24,
                  color: ColorConst.primary,
                ),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: const Icon(Icons.wallet_outlined, size: 24),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.wallet_rounded,
                  size: 24,
                  color: ColorConst.primary,
                ),
              ),
              label: 'Earnings',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: const Icon(Icons.person_outline, size: 24),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person, size: 24, color: ColorConst.primary),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (index) => controller.changePage(index),
        ),
      ),
    );
  }
}
