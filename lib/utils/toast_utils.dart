import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils{
  ToastUtils.__();

  static void show({required String msg}) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
  );
}