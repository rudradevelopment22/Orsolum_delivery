import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/api/api_error.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/extensions.dart';

class DialogUtils {
  DialogUtils.__();

  static bool _showProgress = false;

  static Future<DateTime?> datePicker({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorConst.primary, // header background color
              onPrimary: ColorConst.onPrimary, // header text color
              onSurface: ColorConst.primary,
              surfaceTint: Colors.white,
              // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorConst.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static Future<T?> showApiErrorBottomSheet<T>(ApiError error) =>
      showSimpleBottomSheet<T>(title: error.title, description: error.message);

  static Future<T?> showSimpleBottomSheet<T>({
    required String title,
    required String description,
  }) {
    return Get.bottomSheet(
      _SimpleBottomSheet(title: title, description: description),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  static Future<T?> showBottomSheet<T>({
    required Widget widget,
    Color? backgroundColor,
    bool scrollable = true,
    double? height,
  }) {
    final child =
        scrollable
            ? SizedBox(
              width: 100.w,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Short top bar
                    Container(
                      height: 4,
                      width: 50,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorConst.grey200,
                      ),
                    ),
                    widget,
                  ],
                ),
              ),
            )
            : SizedBox(
              width: 100.w,
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Short top bar
                  Container(
                    height: 4,
                    width: 50,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorConst.grey200,
                    ),
                  ),
                  Expanded(child: widget),
                ],
              ),
            );
    return Get.bottomSheet(
      child,
      backgroundColor: backgroundColor ?? Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  static Future<bool?> showAlertBottomSheet({
    required String title,
    String description = "",
    String confirmText = "Yes",
    String cancelText = "No",
    bool enableButton = true,
  }) {
    return Get.bottomSheet<bool>(
      _AlertBottomSheet(
        title: title,
        description: description,
        confirmText: confirmText,
        cancelText: cancelText,
        enableButton: enableButton,
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 200),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  static Future<String?> showDropdownBottomSheet({
    required List<String> items,
    bool needSearch = false,
    String? searchHint,
  }) {
    return Get.bottomSheet<String>(
      _DropdownBottomSheet(
        needSearch: needSearch,
        searchHint: searchHint,
        items: items,
      ),
      backgroundColor: ColorConst.primaryShade10,
      isScrollControlled: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  static void showProgress() {
    _showProgress = true;
    Get.dialog(const _ProgressDialog(), barrierDismissible: false);
  }

  static void dismissProgress() {
    if (_showProgress) {
      _showProgress = false;
      Get.back();
    }
  }

  static void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }
}

class _DropdownBottomSheet extends StatelessWidget {
  final bool needSearch;
  final List<String> items;
  final RxList<String> filterList;
  final String? searchHint;

  _DropdownBottomSheet({
    required this.needSearch,
    required this.items,
    this.searchHint,
  }) : filterList = RxList(items);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: Get.height / 2,
        maxHeight: Get.height - 300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black26,
              ),
            ),
            const Gap(10),
            TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  filterList.value = items;
                } else {
                  filterList.value =
                      items
                          .where(
                            (e) =>
                                e.toLowerCase().contains(value.toLowerCase()),
                          )
                          .toList();
                }
              },
              style: TextStyles.subTitle2,
              cursorColor: ColorConst.neutralShade90,
              decoration: InputDecoration(
                hintText: searchHint,
                hintStyle: TextStyles.subTitle2.copyWith(
                  color: ColorConst.neutralShade60,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.neutralShade90),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.neutralShade90),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.neutralShade90),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Obx(
                () => ListView(
                  children:
                      filterList.map((e) {
                        return ListTile(
                          onTap: () => Get.back(result: e),
                          title: Text(
                            e,
                            style: TextStyles.subTitle2.copyWith(
                              color: ColorConst.neutralShade95,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleBottomSheet extends StatelessWidget {
  final String title;
  final String description;

  const _SimpleBottomSheet({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

class _AlertBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final bool enableButton;

  const _AlertBottomSheet({
    required this.title,
    required this.confirmText,
    required this.cancelText,
    this.description = "",
    this.enableButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
            if (enableButton) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back(result: false);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: ColorConst.primary),
                        ),
                        backgroundColor: ColorConst.primary,
                        foregroundColor: ColorConst.onPrimary,
                      ),
                      child: Text(
                        cancelText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: ColorConst.primary),
                        ),
                      ),
                      child: Text(
                        confirmText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _ProgressDialog extends StatelessWidget {
  const _ProgressDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(ColorConst.primaryShade5),
      ),
    );
  }
}
