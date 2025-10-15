import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:orsolum_delivery/constant/const.dart';
import 'package:orsolum_delivery/services/permission_service.dart';
import 'package:orsolum_delivery/styles/theme_style.dart';
import 'package:orsolum_delivery/utils/app_utils.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:orsolum_delivery/api/api.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/models/order_model.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_order_controller.dart';
import 'package:orsolum_delivery/modules/orders/new_orders/new_orders_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services
  await Get.putAsync(() => PermissionService().init());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppUtils.init();

  // Register controllers
  Get.put(NewOrderController());

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Const.appName,
      theme: ThemeStyle.light,
      initialRoute: RouterUtils.initial,
      getPages: RouterUtils.pages,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      navigatorObservers: [AppRouteObserver()],
    );
  }
}
