import 'package:get/get.dart';

class UserVerificationController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isBankFilled = false.obs;
  RxBool isPanFilled = false.obs;
  RxBool isAadhaarFilled = false.obs;
  RxBool isVehicleFilled = false.obs;
  RxBool isLicenseFilled = false.obs;

  int get currentStep {
    if (!isBankFilled.value) return 0;
    if (!isPanFilled.value) return 1;
    if (!isAadhaarFilled.value) return 2;
    if (!isVehicleFilled.value) return 3;
    if (!isLicenseFilled.value) return 4;
    return 5; // completed
  }

  void submitStep() {
    switch (currentStep) {
      case 0:
        isBankFilled.value = true;
        break;
      case 1:
        isPanFilled.value = true;
        break;
      case 2:
        isAadhaarFilled.value = true;
        break;
      case 3:
        isVehicleFilled.value = true;
        break;
      case 4:
        isLicenseFilled.value = true;
        break;
      case 5:
        break;
    }
  }
}
