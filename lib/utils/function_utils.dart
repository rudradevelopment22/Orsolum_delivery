import 'package:get/get.dart';
import 'package:orsolum_delivery/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logs_utils.dart';

abstract class FunctionUtils {
  static hideKeyboard() => Get.focusScope?.unfocus();

  static String formatCardNumber(String cardNumber) {
    return cardNumber
        .replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ")
        .trim();
  }

  static dialPadRedirect(String phone) {
    final phoneDialerUrl = "tel:$phone";
    try {
      launchUrl(Uri.parse(phoneDialerUrl));
    } catch (e) {
      ToastUtils.show(msg: "Error on calling number please try again");
      LogsUtils.debug("error on open phone dialer => ${e.toString()}");
    }
  }
}
