import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Any initialization code can go here
  }
}
