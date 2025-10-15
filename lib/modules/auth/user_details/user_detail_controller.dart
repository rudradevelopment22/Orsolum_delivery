import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // for XFile
import 'package:orsolum_delivery/api/api.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/utils/dialog_utils.dart';
import 'package:orsolum_delivery/utils/enum.dart';
import 'package:orsolum_delivery/utils/function_utils.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/utils/toast_utils.dart';
import 'package:orsolum_delivery/api/api_exception.dart';

class UserDetailController extends GetxController {
  final nameTextEditController = TextEditingController();
  final lastNameTextEditController = TextEditingController();
  final emailTextEditController = TextEditingController();
  final dateOfBirthTextEditController = TextEditingController();

  // Store selfie image (from camera)
  final imageFile = Rx<XFile?>(null);

  final formKey = GlobalKey<FormState>();

  void onNextTap() {
    FunctionUtils.hideKeyboard();
    if (formKey.currentState!.validate()) {
      Get.toNamed(RouterUtils.selfieVerification);
    }
  }

  // API call placeholder
  Future<void> uploadSelfie() async {
    if (imageFile.value == null) {
      Get.snackbar("Error", "Please take a selfie first");
      return;
    }
    // 🔗 call your API here with imageFile.value
    _apiCall();
  }

  Future<void> _apiCall() async {
    try {
      DialogUtils.showProgress();
      // Build selfie init payload per contract
      final path = imageFile.value!.path;
      final fileName = path.split('/').isNotEmpty ? path.split('/').last : 'profile-image.jpg';
      final res = await Api.client.put(
        endPoint: ApiConst.userDetail,
        requestBody: {
          "sFileName": fileName,
          "sContentType": "image/jpeg",
        },
      );
      DialogUtils.dismissProgress();
      ToastUtils.show(msg: res.message);
      if (res.status == ApiStatus.success) {
        Get.toNamed(RouterUtils.home);
      }
    } on ApiException catch (e) {
      DialogUtils.dismissProgress();
      ToastUtils.show(msg: e.apiError.message);
    }
  }

}
