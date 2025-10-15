import 'package:get/get.dart';

class RatingController extends GetxController {
  // Star rating (0-5)
  final RxInt selectedRating = 0.obs;

  // Feedback options
  final RxBool customerPolite = false.obs;
  final RxBool clearInstructions = false.obs;
  final RxBool easyToLocate = false.obs;
  final RxBool safeDeliveryArea = false.obs;

  // Additional comments
  final RxString additionalComments = ''.obs;

  // Set star rating
  void setRating(int rating) {
    selectedRating.value = rating;
  }

  // Toggle feedback options
  void toggleCustomerPolite() {
    customerPolite.value = !customerPolite.value;
  }

  void toggleClearInstructions() {
    clearInstructions.value = !clearInstructions.value;
  }

  void toggleEasyToLocate() {
    easyToLocate.value = !easyToLocate.value;
  }

  void toggleSafeDeliveryArea() {
    safeDeliveryArea.value = !safeDeliveryArea.value;
  }

  // Update comments
  void updateComments(String comments) {
    additionalComments.value = comments;
  }

  // Submit rating
  void submitRating() {
    if (selectedRating.value == 0) {
      Get.snackbar('Error', 'Please select a rating');
      return;
    }

    // Here you would typically send the data to your API
    print('Rating: ${selectedRating.value}');
    print('Customer Polite: ${customerPolite.value}');
    print('Clear Instructions: ${clearInstructions.value}');
    print('Easy to Locate: ${easyToLocate.value}');
    print('Safe Delivery Area: ${safeDeliveryArea.value}');
    print('Comments: ${additionalComments.value}');

    Get.snackbar('Success', 'Rating submitted successfully');
    Get.back();
  }
}




