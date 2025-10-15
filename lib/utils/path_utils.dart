import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathUtils {
  PathUtils._();

  static PathUtils? _instance;
  static String? temp;
  static String? rentReport;
  static String? expenseReport;

  /// one time initial
  static PathUtils get instance{
    _instance ??= PathUtils._();
    return _instance!;
  }

  Future<String> getTempDir()async{
    return temp ??= (await getTemporaryDirectory()).path;
  }

  Future<String> getTenantRentReportDirectoryPath()async{
    if(rentReport != null){
      return rentReport!;
    }else{
      if(Platform.isAndroid){
        const dir = "/storage/emulated/0/Document/";
        final dirDocumentExists = await Directory(dir).exists();
        if(dirDocumentExists){
          return rentReport = "/storage/emulated/0/Document";
        }else{
          return rentReport = "/storage/emulated/0/Documents";
        }
      }else{
        return rentReport ??= (await getApplicationDocumentsDirectory()).path;
      }
    }
  }

  Future<String> getExpenseDirectoryPath()async{
    if(expenseReport != null){
      return expenseReport!;
    }else{
      if(Platform.isAndroid){
        const dir = "/storage/emulated/0/Document/";
        final dirDocumentExists = await Directory(dir).exists();
        if(dirDocumentExists){
          return expenseReport = "/storage/emulated/0/Document";
        }else{
          return expenseReport = "/storage/emulated/0/Documents";
        }
      }else{
        return expenseReport ??= (await getApplicationDocumentsDirectory()).path;
      }
    }
  }
}