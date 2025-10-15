import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/models/user_model.dart';
import 'package:orsolum_delivery/utils/app_utils.dart';
import 'package:orsolum_delivery/utils/enum.dart';
import 'package:orsolum_delivery/utils/extensions.dart';
import 'package:orsolum_delivery/utils/logs_utils.dart';
import 'api_error.dart';
import 'api_exception.dart';

class Api {
  late Dio _dio;

  static Api? _instance;

  Api._(Dio dio) {
    _dio = dio;

    /// Ignore or self sign certificate
    /// on testing stage
    if (kDebugMode) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  static final Map<String, dynamic> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  /// one time initial
  static Api get client {
    _instance ??= Api._(
      Dio(
        BaseOptions(
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          headers: _headers,
        ),
      )..interceptors.add(_MyInterceptor()),
    );

    return _instance!;
  }

  Future<ApiRes<T>> get<T>({
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> requestBody = const {},
    required String endPoint,
    bool directJson = false,
    CancelToken? cancelToken,
  }) async {
    final res = await _dio
        .get(
          endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
          cancelToken: cancelToken,
          queryParameters: queryParams,
          // data: requestBody,
          options: Options(headers: _headers),
        )
        .catchError((error) => throw ApiException(error));
    return ApiRes<T>.fromJson(res.data, directJson: directJson);
  }

  Future<ApiRes<T>> post<T>({
    Map<String, dynamic> requestBody = const {},
    Map<String, dynamic> queryParam = const {},
    Map<String, dynamic> header = const {},
    required String endPoint,
    bool directJson = false,
    CancelToken? cancelToken,
  }) async {
    if (header.isNotEmpty) {
      _headers.addAll(header);
    }
    final res = await _dio
        .post(
          endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
          data: requestBody,
          cancelToken: cancelToken,
          queryParameters: queryParam,
          options: Options(headers: _headers),
        )
        .catchError((error) => throw ApiException(error));
    return ApiRes<T>.fromJson(res.data, directJson: directJson);
  }

  Future<ApiRes<T>> put<T>({
    Map<String, dynamic> requestBody = const {},
    Map<String, dynamic> queryParam = const {},
    Map<String, dynamic> header = const {},
    Uint8List? binary,
    required String endPoint,
    bool directJson = false,
    bool bypass = false,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    if (header.isNotEmpty) {
      _headers.addAll(header);
    }

    final res = await _dio
        .put(
          endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
          data: binary ?? requestBody,
          cancelToken: cancelToken,
          queryParameters: queryParam,
          onSendProgress: onSendProgress,
          options: Options(
            requestEncoder: (final request, final options) {
              return binary ?? [];
            },
            headers:
                binary != null
                    ? {
                      Headers.contentLengthHeader: '${binary.length}',
                      Headers.contentTypeHeader: "application/octet-stream",
                    }
                    : _headers,
          ),
        )
        .catchError((error) => throw ApiException(error));
    return ApiRes<T>.fromJson(res.data, directJson: directJson, bypass: bypass);
  }

  Future<ApiRes<T>> delete<T>({
    Map<String, dynamic> requestBody = const {},
    Map<String, dynamic> queryParam = const {},
    required String endPoint,
  }) async {
    final res = await _dio
        .delete(
          endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
          data: requestBody,
          queryParameters: queryParam,
          options: Options(headers: _headers),
        )
        .catchError((error) => throw ApiException(error));
    return ApiRes<T>.fromJson(res.data);
  }

  Future<ApiRes<T>> patch<T>({
    Map<String, dynamic> requestBody = const {},
    Map<String, dynamic> queryParam = const {},
    required String endPoint,
  }) async {
    final res = await _dio
        .patch(
          endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
          data: requestBody,
          queryParameters: queryParam,
          options: Options(headers: _headers),
        )
        .catchError((error) => throw ApiException(error));
    return ApiRes<T>.fromJson(res.data);
  }

  Future<ApiRes<T>> multipart<T>({
    required Map<String, dynamic> requestBody,
    Map<String, dynamic> files = const {},
    required String endPoint,
    ProgressCallback? onSendProgress,
    String? contentType = "post",
  }) async {
    final FormData formData = FormData.fromMap(requestBody);

    if (files.isNotEmpty) {
      files.forEach((key, value) {
        if (value is List<File>) {
          formData.files.addAll(
            List.generate(value.length, (index) {
              final f = value[index];
              return MapEntry(
                "$key[$index]",
                MultipartFile.fromFileSync(f.path, filename: f.filename),
              );
            }).toList(),
          );
        } else if (value is File) {
          formData.files.add(
            MapEntry(
              key,
              MultipartFile.fromFileSync(value.path, filename: value.filename),
            ),
          );
        }
      });
      // formData.files.addAll(files.map((e) => MapEntry(
      //     e.key,
      //     MultipartFile.fromFileSync(
      //       e.value.path,
      //       filename: e.value.filename,
      //     ))).toList());
    }

    if (contentType == "post") {
      final res = await _dio
          .post(
            endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
            data: formData,
            onSendProgress: onSendProgress,
          )
          .catchError((error) => throw ApiException(error));

      return ApiRes<T>.fromJson(res.data);
    } else {
      final res = await _dio
          .put(
            endPoint.contains("https") ? endPoint : ApiConst.baseUrl + endPoint,
            data: formData,
            onSendProgress: onSendProgress,
          )
          .catchError((error) => throw ApiException(error));

      return ApiRes<T>.fromJson(res.data);
    }
  }
}

class _MyInterceptor extends Interceptor {
  @override
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for external APIs (Google, S3, etc.)
    final isExternal = options.path.contains("googleapis.com");

    if (isLogin && !isExternal) {
      options.headers.addAll({"Authorization": user.token});
    }

    LogsUtils.info(
      "Api Request \n"
      "Method : ${options.method}\n"
      "Url : ${options.baseUrl + options.path}\n"
      "Query Param : ${const JsonEncoder.withIndent(' ').convert(options.queryParameters)}\n"
      "body : ${const JsonEncoder.withIndent(' ').convert(options.data is FormData ? _convertFormDataToMap(options.data) : options.data)}\n"
      "Header : ${const JsonEncoder.withIndent(' ').convert(options.headers)}\n",
      name: "Api",
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogsUtils.info(
      "Api Response \n"
      "Url : ${response.requestOptions.baseUrl + response.requestOptions.path}\n"
      "data : ${const JsonEncoder.withIndent(' ').convert(response.data)}",
      name: "Api",
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LogsUtils.error(
      "Api Error \n"
      "url : ${err.requestOptions.path}\n"
      "request : ${err.requestOptions.data is FormData ? ((err.requestOptions.data as FormData).fields.toList().map((e) => {e.key, e.value}).toString()) : err.requestOptions.data}\n"
      "error type : ${err.type.name}\n"
      "error message : ${err.message}\n"
      "error response : ${err.response}\n"
      /*"retry : $retry\n"*/
      "error : ${err.error}\n",
      name: "Api",
    );
    super.onError(err, handler);
  }

  Map<String, dynamic> _convertFormDataToMap(FormData formData) {
    final map = <String, dynamic>{};
    for (var e in formData.fields) {
      map.addAll({e.key: e.value});
    }
    for (var e in formData.files) {
      map.addAll({e.key: e.value.filename ?? ""});
    }
    return map;
  }
}

// Global decoders for API response data parsing
final Map<Type, dynamic Function(dynamic)> _decoders = {
  User: (res) => User.fromJson(res as Map<String, dynamic>),
};

class ApiRes<T> {
  bool success = false;
  String message = "";
  String token = "";
  late T data;

  ApiError apiError = ApiError();
  ApiStatus status = ApiStatus.loading;

  int currentPage = 0;
  int lastPage = 1;
  int cartCount = 0;
  int totalCartCount = 0;

  getx.RxDouble sendProgress = getx.RxDouble(0);

  /// Screens status management
  ApiRes.loading() {
    status = ApiStatus.loading;
  }

  ApiRes.none() {
    status = ApiStatus.none;
  }

  ApiRes.empty(T d) {
    status = ApiStatus.empty;
    data = d;
  }

  ApiRes.data(T d) {
    data = d;
    status = ApiStatus.success;
  }

  ApiRes.error(this.apiError) {
    status = ApiStatus.error;
  }

  ApiRes.fromJson(dynamic json, {directJson = false, bypass = false}) {
    if (bypass) {
      success = true;
      message = "bypass";
      status = ApiStatus.success;
    } else if (directJson) {
      if (json != null) {
        _parsingModel(json);
      } else {
        success = false;
        status = ApiStatus.error;
        throw ApiException(
          "json is coming null in direct json",
          error: ApiError.parsingError(),
        );
      }
    } else {
      success = json["success"] ?? (json["status"] ?? 0) == 200;
      message = json["message"] ?? "";
      token = json["token"] ?? "";

      currentPage = json['current_page'] ?? 0;
      lastPage = json['lastpage'] ?? 1;
      cartCount = json['count'] ?? 0;
      totalCartCount = json['totalCartCount'] ?? json["cartCount"] ?? 0;

      final responseData = json["data"];

      if (success) {
        status = ApiStatus.success;
        _parsingModel(responseData);
      } else {
        status = ApiStatus.error;
        apiError = ApiError(title: "Error", message: message);
        throw ApiException("", error: apiError);
      }
    }
  }

  void _parsingModel(dynamic res) {
    try {
      if (_decoders.containsKey(T)) {
        final decoder = _decoders[T]!;
        data = decoder(res);
        if (data is List && (data as List).isEmpty) {
          status = ApiStatus.empty;
        } else {
          status = ApiStatus.success;
        }
      } else if (T == dynamic) {
        data = res;
        status = ApiStatus.success;
      } else {
        success = false;
        message = "Something went wrong";
        status = ApiStatus.error;
        throw ApiException(
          "Your mention type ${T.toString()} is not in our list",
        );
      }
    } catch (e, s) {
      success = false;
      message = "Something went wrong";
      status = ApiStatus.error;
      throw ApiException(
        "Error on parsing ${T.toString()} Object \n Error : ${e.toString()}\n Stack : ${s.toString()}",
      );
    }
  }
}
