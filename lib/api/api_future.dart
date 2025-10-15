import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/api/api.dart';
import 'package:orsolum_delivery/utils/enum.dart';
import '../constant/asset_const.dart';
import 'api_error.dart';

class ApiFuture<T> extends StatelessWidget {
  final Rx<ApiRes<T>> rxValue;
  final Function widget;
  final VoidCallback? onRetryTap;
  final Function? loadingView;
  final Function? errorView;
  final Function? emptyView;
  final Function? noneView;
  final Color? errorColor;

  const ApiFuture({
    super.key,
    required this.rxValue,
    required this.widget,
    this.onRetryTap,
    this.loadingView,
    this.errorView,
    this.emptyView,
    this.noneView,
    this.errorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (rxValue.value.status) {
        case ApiStatus.loading:
          if (loadingView != null) {
            return loadingView!();
          } else {
            return const _DefaultLoadingView();
          }
        case ApiStatus.success:
          return widget();
        case ApiStatus.empty:
          if (emptyView != null) {
            return emptyView!();
          } else {
            return const _DefaultEmptyView();
          }
        case ApiStatus.error:
          if (errorView != null) {
            return errorView!();
          } else {
            return _DefaultErrorView(
              apiError: rxValue.value.apiError,
              onRetryTap: onRetryTap,
              retry: onRetryTap != null,
            );
          }
        default:
          return noneView == null ? const SizedBox() : noneView!();
      }
    });
  }
}

class _DefaultLoadingView extends StatelessWidget {
  const _DefaultLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

class _DefaultEmptyView extends StatelessWidget {
  const _DefaultEmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetConst.orderHistory,
              height: 200, // Set your desired height
              width: 200, // Set your desired width
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              "No Data found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultErrorView extends StatelessWidget {
  final ApiError apiError;
  final bool retry;
  final VoidCallback? onRetryTap;
  final bool backButton;
  final bool needScaffold;

  const _DefaultErrorView({
    super.key,
    required this.apiError,
    this.retry = false,
    this.onRetryTap,
    this.backButton = false,
    this.needScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Optional: Add an error illustration
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              apiError.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              apiError.message,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            if (retry) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRetryTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (needScaffold) {
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar:
            backButton
                ? AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.black),
                )
                : null,
        body: content,
      );
    } else {
      return Padding(padding: const EdgeInsets.all(16.0), child: content);
    }
  }
}
