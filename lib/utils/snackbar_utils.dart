import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/api/api_error.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

abstract class SnackBarUtils {
  static void showSuccess({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ColorConst.accentSuccess,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: TextStyles.headline5.copyWith(color: Colors.white),
        ),
        messageText: Text(
          message,
          style: TextStyles.subTitle2.copyWith(color: Colors.white),
        ),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  static void showError({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ColorConst.accentDanger,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: TextStyles.headline5.copyWith(color: Colors.white),
        ),
        messageText: Text(
          message,
          style: TextStyles.subTitle2.copyWith(color: Colors.white),
        ),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  static void showApiError({required ApiError apiError}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ColorConst.accentDanger,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          apiError.title,
          style: TextStyles.headline5.copyWith(color: Colors.white),
        ),
        messageText: Text(
          apiError.message,
          style: TextStyles.subTitle2.copyWith(color: Colors.white),
        ),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  static void showInfo({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ColorConst.accentInfo,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: TextStyles.headline5.copyWith(color: Colors.white),
        ),
        messageText: Text(
          message,
          style: TextStyles.subTitle2.copyWith(color: Colors.white),
        ),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  static void showWarning({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ColorConst.accentWarning,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: TextStyles.headline5.copyWith(color: Colors.white),
        ),
        messageText: Text(
          message,
          style: TextStyles.subTitle2.copyWith(color: Colors.white),
        ),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
