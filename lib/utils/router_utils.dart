import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/modules/accounts/account_page/accounts_controller.dart';
import 'package:orsolum_delivery/modules/accounts/account_page/accounts_screen.dart';
import 'package:orsolum_delivery/modules/accounts/edit_profile/edit_profile_controller.dart';
import 'package:orsolum_delivery/modules/accounts/edit_profile/edit_profile_screen.dart';
import 'package:orsolum_delivery/modules/accounts/help_support/help_support_screen.dart';
import 'package:orsolum_delivery/modules/accounts/history/order_history_controller.dart';
import 'package:orsolum_delivery/modules/accounts/history/order_history_screen.dart';
import 'package:orsolum_delivery/modules/app_language/app_language.dart';
import 'package:orsolum_delivery/modules/app_language/app_language_controller.dart';
import 'package:orsolum_delivery/modules/auth/auth_controller.dart';
import 'package:orsolum_delivery/modules/auth/login_screen.dart';
import 'package:orsolum_delivery/modules/auth/otp/otp_page.dart';
import 'package:orsolum_delivery/modules/auth/register/register_screen.dart';
import 'package:orsolum_delivery/modules/auth/user_details/selfie_camera_page.dart';
import 'package:orsolum_delivery/modules/auth/user_details/selfie_verifivcation_screen.dart';
import 'package:orsolum_delivery/modules/auth/user_details/user_detail_controller.dart';
import 'package:orsolum_delivery/modules/auth/user_details/user_detail_screen.dart';
import 'package:orsolum_delivery/modules/cash_collection/cash_collection_controller.dart';
import 'package:orsolum_delivery/modules/cash_collection/cash_collection_screen.dart';
import 'package:orsolum_delivery/modules/cash_collection/settle_collection/settle_collection_screen.dart';
import 'package:orsolum_delivery/modules/city_selection/city_controller.dart';
import 'package:orsolum_delivery/modules/city_selection/city_selection_screen.dart';
import 'package:orsolum_delivery/modules/delivery_tracking/chat/chat_controller.dart';
import 'package:orsolum_delivery/modules/delivery_tracking/chat/chat_screen.dart';
import 'package:orsolum_delivery/modules/earnings/earnings_report_page.dart';
import 'package:orsolum_delivery/modules/earnings/earnings_summary_page.dart';
import 'package:orsolum_delivery/modules/home/home_controller.dart';
import 'package:orsolum_delivery/modules/home/home_screen.dart';
import 'package:orsolum_delivery/modules/main/main_screen.dart';
import 'package:orsolum_delivery/modules/notification/notification_controller.dart';
import 'package:orsolum_delivery/modules/notification/notification_screen.dart';
import 'package:orsolum_delivery/modules/orders/completed/complitan_screen.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_order_controller.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_orders_screen.dart';
import 'package:orsolum_delivery/modules/orders/order_details/order_details_contoller.dart';
import 'package:orsolum_delivery/modules/orders/order_details/order_details_screen.dart';
import 'package:orsolum_delivery/modules/orders/payment/payment_controller.dart';
import 'package:orsolum_delivery/modules/orders/payment/payment_screen.dart';
import 'package:orsolum_delivery/modules/splash/splash_controller.dart';
import 'package:orsolum_delivery/modules/splash/splash_screen.dart';
import 'package:orsolum_delivery/modules/user_verification/user_verification_controller.dart';
import 'package:orsolum_delivery/modules/user_verification/user_verification_screen.dart';
import 'package:orsolum_delivery/modules/working_hours/working_hours_controller.dart';
import 'package:orsolum_delivery/modules/working_hours/working_hours_screen.dart';
import 'package:orsolum_delivery/modules/delivery_tracking/delivery_tracking_screen.dart';
import 'package:orsolum_delivery/modules/delivery_tracking/delivery_tracking_controller.dart';
import 'package:orsolum_delivery/services/socket_service.dart';
import 'package:orsolum_delivery/utils/logs_utils.dart';

abstract class RouterUtils {
  static String initial = splash;

  /// Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String register = '/register';
  static const String userDetail = '/user_detail';
  static const String selfieVerification = '/selfie_verification';
  static const String selfieCamera = '/selfie_camera';
  static const String userVerification = '/user_verification';

  static const String selectCity = '/select_city';
  static const String workingHours = '/working_hours';

  static const String home = '/main'; // Main screen with bottom navigation
  static const String homePage = '/home'; // Individual home page
  static const String newOrders = '/new_orders';
  static const String orderDetailsScreen = '/order_details_screen';
  static const String completed = '/completed';
  static const String payment = '/payment';

  static const String notification = '/notification';

  static const String earnings = '/earnings';
  static const String earningsSummary = '/earnings_summary';
  static const String earningsReport = '/earnings_report';

  static const String account = '/account';
  static const String editProfile = '/edit_profile';
  static const String helpSupport = '/help_support';
  static const String appLanguage = '/app_language';

  static const String cashCollection = '/cash_collection';
  static const String settleCollection = '/settle_collection';

  static const String addAddress = '/add_address';

  static const String orderHistory = '/order_history';

  // static const String orderDetails = '/order_details';
  // static const String returnOrder = '/return_order';

  // static const String saveReels = '/save_reels';

  // static const String terms = '/terms';

  // static const String brands = '/brands';

  // static const String membership = '/membership';

  // static const String weather = '/weather';

  // static const String addCrop = '/add_crop';

  // static const String agricultureAdvice = '/agriculture_advice';

  static const String deliveryTracking = '/delivery_tracking';
  static const String chat = '/chat';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController()); // Use put for immediate initialization
      }),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthController())),
    ),
    GetPage(
      name: otp,
      page: () => OtpPage(),
      // binding: BindingsBuilder(() => Get.lazyPut(() => OtpController())),
    ),
    GetPage(
      name: deliveryTracking,
      page: () => const DeliveryTrackingScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => DeliveryTrackingController()),
      ),
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      // binding: BindingsBuilder(() => Get.lazyPut(() => RegisterController())),
    ),
    GetPage(
      name: userDetail,
      page: () => UserDetailScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserDetailController())),
    ),
    GetPage(name: selfieVerification, page: () => SelfieVerificationScreen()),
    GetPage(name: selfieCamera, page: () => SelfieCameraPage()),
    GetPage(
      name: userVerification,
      page: () => UserVerificationScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => UserVerificationController()),
      ),
    ),
    GetPage(
      name: selectCity,
      page: () => CitySelectionScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => CityController())),
    ),
    GetPage(
      name: workingHours,
      page: () => WorkingHoursScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => WorkingHoursController()),
      ),
    ),
    GetPage(
      name: home,
      page: () => MainScreen(),
      bindings: [
        BindingsBuilder(() => Get.lazyPut(() => SocketService())),
        BindingsBuilder(() => Get.lazyPut(() => HomeController())),
        BindingsBuilder(() => Get.lazyPut(() => NotificationController())),
        BindingsBuilder(() => Get.lazyPut(() => AccountsController())),
      ],
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => HomeController())),
    ),
    GetPage(
      name: newOrders,
      page: () => NewOrdersScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => NewOrderController())),
    ),
    GetPage(
      name: orderDetailsScreen,
      page: () => OrderDetailsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => OrderDetailsController()),
      ),
    ),
    GetPage(
      name: payment,
      page: () => PaymentScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PaymentController())),
    ),
    GetPage(name: completed, page: () => CompletedScreen()),
    GetPage(name: account, page: () => AccountPage()),
    GetPage(
      name: editProfile,
      page: () => EditProfilePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => EditProfileController()),
      ),
    ),
    GetPage(
      name: orderHistory,
      page: () => OrderHistoryScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => OrderHistoryController()),
      ),
    ),
    GetPage(
      name: notification,
      page: () => NotificationsPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => NotificationController()),
      ),
    ),
    GetPage(name: earningsSummary, page: () => EarningsSummaryPage()),
    GetPage(name: earningsReport, page: () => EarningsReportPage()),
    GetPage(
      name: cashCollection,
      page: () => CashCollectionPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => CashCollectionController()),
      ),
    ),
    GetPage(name: settleCollection, page: () => SettleCollectionScreen()),
    GetPage(name: helpSupport, page: () => HelpSupportScreen()),
    GetPage(
      name: chat,
      page: () => ChatScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ChatController())),
    ),
    GetPage(
      name: appLanguage,
      page: () => AppLanguage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AppLanguageController()),
      ),
    ),
  ];
}

class AppRouteObserver extends RouteObserver<ModalRoute<dynamic>> {
  static final AppRouteObserver _instance = AppRouteObserver._internal();
  static List<String> routerNames = [];
  final _routeChangeController = StreamController<String>.broadcast();

  factory AppRouteObserver() {
    return _instance;
  }

  AppRouteObserver._internal();

  /// Stream that emits the current route name whenever it changes
  Stream<String> get onRouteChanged => _routeChangeController.stream;

  static bool containsRoute(String routeName) {
    return routerNames.any((route) => route == routeName);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      final routeName = route.settings.name!;
      routerNames.add(routeName);
      _routeChangeController.add(routeName);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      routerNames.remove(route.settings.name!);
      if (previousRoute?.settings.name != null) {
        _routeChangeController.add(previousRoute!.settings.name!);
      }
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      routerNames.remove(route.settings.name!);
      if (previousRoute?.settings.name != null) {
        _routeChangeController.add(previousRoute!.settings.name!);
      }
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    try {
      if (oldRoute?.settings.name != null) {
        final index = routerNames.indexOf(oldRoute!.settings.name!);
        if (index != -1 && newRoute?.settings.name != null) {
          routerNames[index] = newRoute!.settings.name!;
          _routeChangeController.add(newRoute.settings.name!);
        } else {
          routerNames.remove(oldRoute.settings.name!);
        }
      }
    } catch (e) {
      LogsUtils.error(
        "Error on didReplace => ${e.toString()}",
        name: "AppRouteObserver",
      );
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void dispose() {
    _routeChangeController.close();
  }
}
