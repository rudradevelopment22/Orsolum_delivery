import 'package:orsolum_delivery/models/user_model.dart';
import 'package:orsolum_delivery/utils/storage_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'router_utils.dart';

User user = User();

bool get isLogin => user.id.isNotEmpty;

class AppUtils {
  AppUtils._();

  static late final PackageInfo packageInfo;

  static late String _stage;

  static get isTestingStage => _stage == "test";

  static get isProductionStage => _stage == "prod";

  static get isDevelopmentStage => _stage == "beta";

  static Future<void> init() async {
    _stage = const String.fromEnvironment("stage");

    packageInfo = await PackageInfo.fromPlatform();

    RouterUtils.initial = await _checkLogin();
  }

  static Future<String> _checkLogin() async {
    /// Check Logged in or not
    String route = "";
    final userDetails = await StorageUtils.instance.getUser();
    if (userDetails != null) {
      user = userDetails;
      route = RouterUtils.home;
    } else {
      route = RouterUtils.splash;
    }

    return route;
  }
}
