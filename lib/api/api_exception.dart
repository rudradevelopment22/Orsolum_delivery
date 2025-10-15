import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/models/user_model.dart';
import 'package:orsolum_delivery/utils/app_utils.dart';
import 'package:orsolum_delivery/utils/logs_utils.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/utils/storage_utils.dart';
import 'package:orsolum_delivery/utils/toast_utils.dart';

import 'api_error.dart';

class ApiException implements Exception {
  final dynamic _exception;
  ApiError apiError = ApiError();
  int code = 200;
  dynamic response;

  ApiException(this._exception, {ApiError? error}) {
    _manageException(error);
  }

  void _manageException(ApiError? error) {
    switch (_exception.runtimeType) {
      case const (DioException):
        _dioException();
        break;
      case const (String):
        LogsUtils.error(_exception as String);
        apiError = error ?? ApiError.unknown();
        break;
      default:
        apiError = error ?? ApiError.unknown();
        break;
    }
  }

  void _dioException() {
    final error = _exception as DioException;
    response = error.response?.data;
    switch (error.type) {
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          apiError = ApiError.noInternet();
        } else {
          apiError = ApiError.unknown();
        }
        break;
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        apiError = ApiError.connectionError();
        break;
      case DioExceptionType.badResponse:
        code = error.response!.statusCode ?? 0;
        final data = error.response!.data;
        if (error.response!.statusCode == 404) {
          apiError = ApiError.notFound();
        } else if (error.response!.statusCode == 405) {
          apiError = ApiError.notFound();
        } else if (error.response!.statusCode == 403) {
          apiError = ApiError.unknown();
        } else if (error.response!.statusCode == 401) {
          apiError = ApiError.unauthorized();
          ToastUtils.show(msg: "Session Expired");
          StorageUtils.instance.removeUserDetails().then((value) {
            user = User();
            Get.offAllNamed(RouterUtils.login);
          });
        } else if (error.response!.statusCode == 400) {
          apiError = ApiError.unknown();
        } else if (error.response!.statusCode == 500 ||
            error.response!.statusCode == 502) {
          apiError = ApiError.serverError();
        } else {
          apiError = ApiError(
            title: "Error",
            message:
                data['message'] ??
                "Our server is not reachable right now. We are working to fix it as soon as possible.",
          );
        }
        if (data != null) {
          try {
            apiError = ApiError(title: "Error", message: data["message"]);
          } catch (_) {
            apiError = ApiError.unknown();
          }
        }
        break;
      default:
        apiError = ApiError.unknown();
        break;
    }
  }
}
