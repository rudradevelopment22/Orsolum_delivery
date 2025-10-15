import 'dart:developer' as developer;

class LogsUtils {
  LogsUtils._();

  static void verbose(String msg, {dynamic error, StackTrace? stackTrace,String name = ""}) =>
      developer.log(msg,error: error,stackTrace: stackTrace,level: 1,name: name);

  static void debug(String msg, {dynamic error, StackTrace? stackTrace,String name = ""}) =>
      developer.log(msg,error: error,stackTrace: stackTrace,level: 2,name: name);

  static void error(String msg, {dynamic error, StackTrace? stackTrace,String name = ""})async{
    developer.log(msg,error: error,stackTrace: stackTrace,level: 5,name: name);
  }

  static void info(String msg, {dynamic error, StackTrace? stackTrace,String name = ""}) =>
      developer.log(msg,error: error,stackTrace: stackTrace,level: 3,name: name);
}