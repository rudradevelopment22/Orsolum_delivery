import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/api/api.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/api/api_exception.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/models/city_model.dart';
import 'package:orsolum_delivery/models/state_model.dart';
import 'package:orsolum_delivery/models/user_model.dart';
import 'package:orsolum_delivery/utils/dialog_utils.dart';
import 'package:orsolum_delivery/utils/enum.dart';
import 'package:orsolum_delivery/utils/function_utils.dart';
import 'package:orsolum_delivery/utils/logs_utils.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/utils/storage_utils.dart';
import 'package:orsolum_delivery/utils/toast_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/app_utils.dart';

class AuthController extends GetxController with GetTickerProviderStateMixin {
  final phoneTextEditController = TextEditingController();
  final otpTextFieldController = TextEditingController();
  final GlobalKey<FormFieldState> stateFormField = GlobalKey<FormFieldState>();

  RxString selectedState = RxString('');
  RxString selectedCity = RxString('');

  // StateModel? selectedState;
  // CityModel? selectedCity;

  // late final TabController tabController;
  // RxInt pageIndex = RxInt(0);
  //
  // int get _loginTabIndex => 0;
  //
  // int get _registerTabIndex => 1;
  //
  // int get _otpTabIndex => 2;

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  late StreamController<ErrorAnimationType> otpErrorAnimationController;

  final _timerLimitTime = 60;
  RxInt otpTimerSec = RxInt(60);

  Timer? _otpTimer;

  double get otpTimerProgress => (otpTimerSec.value / 60);

  late final BuildContext? context;

  /// Status
  final rxApiLoginStatus = Rx(ApiStatus.none);
  final rxApiOtpVerifyStatus = Rx(ApiStatus.none);
  final rxApiRegisterStatus = Rx(ApiStatus.none);

  CancelToken cancelTokenLogin = CancelToken();
  CancelToken cancelTokenRegister = CancelToken();
  CancelToken cancelTokenVerifyOtp = CancelToken();

  List<StateModel> states = [];
  List<CityModel> selectedStateCities = [];

  final loginErrorText = Rx<String?>(null);

  @override
  void onInit() {
    context = Get.context!;
    _loadStates();
    otpErrorAnimationController = StreamController();
    // tabController = TabController(
    //   length: 3,
    //   vsync: this,
    //   animationDuration: const Duration(milliseconds: 300),
    // );
    super.onInit();
  }

  @override
  void onClose() {
    cancelTokenLogin.cancel();
    cancelTokenRegister.cancel();
    cancelTokenVerifyOtp.cancel();
    super.onClose();
  }

  Future<void> _loadStates() async {
    String data = await DefaultAssetBundle.of(
      Get.context!,
    ).loadString(AssetConst.indiaStatesJson);
    states = StateModel.fromJsonList((jsonDecode(data) as List<dynamic>));
  }

  void onLoginTap() {
    FunctionUtils.hideKeyboard();
    loginErrorText.value = null;
    if (loginFormKey.currentState!.validate()) {
      final raw = phoneTextEditController.text;
      final normalized = raw.replaceAll(RegExp(r"[^0-9]"), "");
      phoneTextEditController.text = normalized;
      _apiLoginOtp(false);
    }
  }

  void onBackTap() {
    FunctionUtils.hideKeyboard();
    otpErrorAnimationController.close();
    otpErrorAnimationController = StreamController();
    otpTextFieldController.clear();
    // if (tabController.index > 0) {
    //   if (tabController.index == _registerTabIndex) {
    //     _changePage(_loginTabIndex);
    //     _clearFieldsController();
    //   } else {
    //     if (tabController.index == _otpTabIndex) {
    //       _changePage(
    //         nameTextEditController.text.trim().isEmpty
    //             ? _loginTabIndex
    //             : _registerTabIndex,
    //       );
    //       otpErrorAnimationController.close();
    //       otpErrorAnimationController = StreamController();
    //       otpTextFieldController.clear();
    //     } else {
    //       _changePage(tabController.index - 1);
    //     }
    //   }
    // } else {
    //   Get.back();
    // }
    _stopTimer();
  }

  Future<bool> onWillPop() async {
    onBackTap();
    return false;
  }

  void stateAndCityValidation() {
    if (selectedState.value.isEmpty) {
      ToastUtils.show(msg: "Please select state");
    } else if (selectedCity.value.isEmpty) {
      ToastUtils.show(msg: "Please select city");
    }
  }

  void onRegisterTap() {
    FunctionUtils.hideKeyboard();
    if (registerFormKey.currentState!.validate() &&
        selectedState.value.isNotEmpty &&
        selectedCity.value.isNotEmpty) {
      _apiRegisterOtp(false);
      // _apiRegisterDirect();
      // apiRegisterOtp(false)
    }
  }

  void onRegisterFromLoginTab() {
    FunctionUtils.hideKeyboard();
    if (rxApiLoginStatus.value != ApiStatus.loading) {
      Get.offNamed(RouterUtils.register);
      loginFormKey.currentState!.reset();
    }
  }

  // void _changePage(int index) {
  //   tabController.animateTo(
  //     index,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  void onOtpTextFieldChanged(String value) {}

  void onOtpTextFieldCompleted(String value) {}

  void _startTimer() {
    otpTimerSec.value = _timerLimitTime;
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      otpTimerSec.value = otpTimerSec.value - 1;
      if (otpTimerSec.value < 1) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _otpTimer?.cancel();
  }

  void onResendTap() {
    FunctionUtils.hideKeyboard();
    if (selectedState.value.isNotEmpty && selectedCity.value.isNotEmpty) {
      final raw = phoneTextEditController.text;
      final normalized = raw.replaceAll(RegExp(r"[^0-9]"), "");
      phoneTextEditController.text = normalized;
      _apiRegisterOtp(true);
    } else {
      final raw = phoneTextEditController.text;
      final normalized = raw.replaceAll(RegExp(r"[^0-9]"), "");
      phoneTextEditController.text = normalized;
      _apiLoginOtp(true);
    }
  }

  void onLoginFromRegisterTap() {
    if (rxApiRegisterStatus.value != ApiStatus.loading) {
      Get.offNamed(RouterUtils.login);
      // _changePage(_loginTabIndex);
      _clearFieldsController();
    }
  }

  void _clearFieldsController() {
    phoneTextEditController.clear();
    registerFormKey.currentState!.reset();
    otpFormKey.currentState!.reset();

    otpErrorAnimationController.close();
    otpErrorAnimationController = StreamController();

    rxApiRegisterStatus.value = ApiStatus.none;
    rxApiLoginStatus.value = ApiStatus.none;
    rxApiOtpVerifyStatus.value = ApiStatus.none;

    cancelTokenLogin.cancel();
    cancelTokenRegister.cancel();
    cancelTokenVerifyOtp.cancel();

    cancelTokenLogin = CancelToken();
    cancelTokenRegister = CancelToken();
    cancelTokenVerifyOtp = CancelToken();
  }

  void onPencilTap() {
    FunctionUtils.hideKeyboard();
    Get.back();
    _stopTimer();
    otpTextFieldController.clear();
    otpErrorAnimationController.close();
    otpErrorAnimationController = StreamController();
  }

  void onVerifyTap() {
    FunctionUtils.hideKeyboard();
    final otp = otpTextFieldController.text.trim();
    if (otp.isEmpty || otp.length != 6) {
      ToastUtils.show(msg: "Please enter 6-digit OTP");
      return;
    }
    if (otpFormKey.currentState!.validate()) {
      otpErrorAnimationController.sink.add(ErrorAnimationType.clear);
      if (selectedState.value != "") {
        _apiRegisterUser();
      } else {
        _apiLoginUser();
      }
    } else {
      otpErrorAnimationController.sink.add(ErrorAnimationType.shake);
    }
  }

  Future<void> _apiLoginOtp(bool forResendOtp) async {
    try {
      if (forResendOtp) {
        DialogUtils.showProgress();
      } else {
        rxApiLoginStatus.value = ApiStatus.loading;
      }

      // Log request
      LogsUtils.info(
        "[LOGIN_OTP] → endpoint: ${ApiConst.loginOtp}, body: {phone: +91${phoneTextEditController.text}}",
      );
      print(
        "[LOGIN_OTP] → endpoint: ${ApiConst.loginOtp}, body: {phone: +91${phoneTextEditController.text}}",
      );

      final res = await Api.client.post(
        cancelToken: cancelTokenLogin,
        endPoint: ApiConst.loginOtp,
        requestBody: {"phone": "+91${phoneTextEditController.text}"},
      );

      // Log response
      LogsUtils.info(
        "[LOGIN_OTP] ← status: ${res.status}, message: ${res.message}",
      );
      print(
        "[LOGIN_OTP] ← status: ${res.status}, message: ${res.message}",
      );

      if (forResendOtp) {
        DialogUtils.dismissProgress();
        _startTimer();
        otpTimerSec.value = _timerLimitTime;
        ToastUtils.show(msg: res.message);
      } else {
        Get.toNamed(RouterUtils.otp);
        _startTimer();
        rxApiLoginStatus.value = res.status;
      }
    } on ApiException catch (e) {
      LogsUtils.error(
        "[LOGIN_OTP] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      print(
        "[LOGIN_OTP] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      if (forResendOtp) {
        DialogUtils.dismissProgress();
        ToastUtils.show(msg: "Something went wrong on resend otp");
      } else {
        rxApiLoginStatus.value = ApiStatus.none;
        loginErrorText.value = e.apiError.message;
      }
    }
  }

  Future<void> _apiLoginUser() async {
    try {
      rxApiOtpVerifyStatus.value = ApiStatus.loading;
      LogsUtils.info(
        "[LOGIN_USER] → endpoint: ${ApiConst.login}, body: {phone: +91${phoneTextEditController.text}, otp: ${otpTextFieldController.text}}",
      );
      print(
        "[LOGIN_USER] → endpoint: ${ApiConst.login}, body: {phone: +91${phoneTextEditController.text}, otp: ${otpTextFieldController.text}}",
      );
      final res = await Api.client.post<User>(
        cancelToken: cancelTokenLogin,
        endPoint: ApiConst.login,
        requestBody: {
          "phone": "+91${phoneTextEditController.text}",
          "otp": otpTextFieldController.text,
        },
      );

      LogsUtils.info(
        "[LOGIN_USER] ← status: ${res.status}, token: ${res.token}, userId: ${res.data.id}",
      );
      print(
        "[LOGIN_USER] ← status: ${res.status}, token: ${res.token}, userId: ${res.data.id}",
      );

      // Set token from base response to user response
      user = res.data;
      user.token = res.token;

      // Save user data to secure storage
      await StorageUtils.instance.saveUser(user);

      // Verify the user was saved
      final savedUser = await StorageUtils.instance.getUser();
      if (savedUser == null) {
        throw Exception('Failed to save user data');
      }

      // Clear controllers and reset state
      phoneTextEditController.clear();
      otpTextFieldController.clear();
      _stopTimer();

      // Navigate to home screen
      await Get.offAllNamed(RouterUtils.home);
      rxApiOtpVerifyStatus.value = res.status;
    } on ApiException catch (e) {
      LogsUtils.error(
        "[LOGIN_USER] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      print(
        "[LOGIN_USER] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      rxApiOtpVerifyStatus.value = ApiStatus.none;
      otpErrorAnimationController.add(ErrorAnimationType.shake);
      ToastUtils.show(msg: e.apiError.title);
    } catch (e) {
      rxApiOtpVerifyStatus.value = ApiStatus.none;
      LogsUtils.error("Error on login user => ${e.toString()}");
      ToastUtils.show(msg: "Something went wrong");
    }
  }

  Future<void> _apiRegisterOtp(bool forResendOtp) async {
    try {
      if (forResendOtp) {
        DialogUtils.showProgress();
      } else {
        rxApiRegisterStatus.value = ApiStatus.loading;
      }

      LogsUtils.info(
        "[REGISTER_OTP] → endpoint: ${ApiConst.registerOtp}, body: {phone: +91${phoneTextEditController.text}}",
      );
      print(
        "[REGISTER_OTP] → endpoint: ${ApiConst.registerOtp}, body: {phone: +91${phoneTextEditController.text}}",
      );
      final res = await Api.client.post(
        cancelToken: cancelTokenLogin,
        endPoint: ApiConst.registerOtp,
        requestBody: {"phone": "+91${phoneTextEditController.text}"},
      );

      LogsUtils.info(
        "[REGISTER_OTP] ← status: ${res.status}, message: ${res.message}",
      );
      print(
        "[REGISTER_OTP] ← status: ${res.status}, message: ${res.message}",
      );

      if (forResendOtp) {
        DialogUtils.dismissProgress();
        _startTimer();
        otpTimerSec.value = _timerLimitTime;
        ToastUtils.show(msg: res.message);
      } else {
        Get.toNamed(RouterUtils.otp);
        _startTimer();
        rxApiRegisterStatus.value = res.status;
      }
    } on ApiException catch (e) {
      LogsUtils.error(
        "[REGISTER_OTP] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      print(
        "[REGISTER_OTP] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      final message = (e.apiError.message).toLowerCase();
      if (message.contains('already exists')) {
        // If account exists, redirect user to login with helpful context
        loginErrorText.value = 'Account already exists. Please login.';
        // Keep the entered phone for convenience
        Get.offNamed(RouterUtils.login);
        return;
      }
      if (forResendOtp) {
        DialogUtils.dismissProgress();
        ToastUtils.show(msg: "Something went wrong on resend otp");
      } else {
        rxApiRegisterStatus.value = ApiStatus.none;
        loginErrorText.value = e.apiError.message;
      }
    }
  }

  Future<void> _apiRegisterUser() async {
    try {
      rxApiOtpVerifyStatus.value = ApiStatus.loading;
      LogsUtils.info(
        "[REGISTER_USER] → endpoint: ${ApiConst.register}, body: {phone: +91${phoneTextEditController.text}, otp: ${otpTextFieldController.text}, state: ${selectedState.value}, city: ${selectedCity.value}}",
      );
      print(
        "[REGISTER_USER] → endpoint: ${ApiConst.register}, body: {phone: +91${phoneTextEditController.text}, otp: ${otpTextFieldController.text}, state: ${selectedState.value}, city: ${selectedCity.value}}",
      );
      final res = await Api.client.post<User>(
        cancelToken: cancelTokenLogin,
        endPoint: ApiConst.register,
        requestBody: {
          "phone": "+91${phoneTextEditController.text}",
          "otp": otpTextFieldController.text,
          "state": selectedState.value,
          "city": selectedCity.value,
        },
      );

      LogsUtils.info(
        "[REGISTER_USER] ← status: ${res.status}, token: ${res.token}, userId: ${res.data.id}",
      );
      print(
        "[REGISTER_USER] ← status: ${res.status}, token: ${res.token}, userId: ${res.data.id}",
      );

      /// set token from base response to user response
      res.data.token = res.token;
      user = res.data;
      await StorageUtils.instance.saveUser(user);

      Get.offAllNamed(RouterUtils.userDetail);
    } on ApiException catch (e) {
      LogsUtils.error(
        "[REGISTER_USER] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      print(
        "[REGISTER_USER] ✖ ApiException: title=${e.apiError.title}, message=${e.apiError.message}",
      );
      rxApiOtpVerifyStatus.value = ApiStatus.none;
      otpErrorAnimationController.add(ErrorAnimationType.shake);
      ToastUtils.show(msg: e.apiError.title);
    } catch (e) {
      rxApiOtpVerifyStatus.value = ApiStatus.none;
      LogsUtils.error("Error on register user => ${e.toString()}");
      ToastUtils.show(msg: "Something went wrong");
    }
  }

  // Future<void> _apiRegisterDirect() async {
  //   try {
  //     rxApiRegisterStatus.value = ApiStatus.loading;
  //     final res = await Api.client.post<User>(
  //       cancelToken: cancelTokenRegister,
  //       endPoint: ApiConst.register,
  //       requestBody: {
  //         "phone": "+91${phoneTextEditController.text}",
  //         "state": selectedState.value,
  //         "city": selectedCity.value,
  //       },
  //     );
  //     res.data.token = res.token;
  //     user = res.data;
  //     await StorageUtils.instance.saveUser(user);

  //     phoneTextEditController.clear();
  //     rxApiRegisterStatus.value = ApiStatus.success;
  //     await Get.offAllNamed(RouterUtils.userDetail);
  //   } on ApiException catch (e) {
  //     rxApiRegisterStatus.value = ApiStatus.none;
  //     ToastUtils.show(msg: e.apiError.title);
  //   } catch (e) {
  //     rxApiRegisterStatus.value = ApiStatus.none;
  //     LogsUtils.error("Error on direct register => ${e.toString()}");
  //     ToastUtils.show(msg: "Something went wrong");
  //   }
  // }
}
