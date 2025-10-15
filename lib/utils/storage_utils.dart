import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orsolum_delivery/models/user_model.dart';

import 'logs_utils.dart';

class StorageUtils {
  static StorageUtils? _instance;
  static FlutterSecureStorage? _storage;

  /// one time initial
  static StorageUtils get instance {
    _instance ??= StorageUtils._();
    return _instance!;
  }

  StorageUtils._() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  /// Keys
  static const String userKey = '0';

  /// ***************************** STORAGE METHOD *****************************
  Future<void> write({required String key, required String value}) =>
      _storage!.write(key: key, value: value);

  Future<String?> read({required String key}) => _storage!.read(key: key);

  Future<void> delete({required String key}) => _storage!.delete(key: key);

  Future<void> deleteAll() => _storage!.deleteAll();

  /// ***************************** USER METHODS *******************************

  Future<void> saveUser(User user) async {
    try {
      await _storage!.write(key: userKey, value: user.toString());
    } catch (e) {
      LogsUtils.error(
        "Error on write user model in secure storage\n Error : ${e.toString()}",
      );
    }
  }

  Future<User?> getUser() async {
    final str = await _storage!.read(key: userKey);
    if (str != null && str.isNotEmpty) {
      return User.fromString(str);
    } else {
      LogsUtils.error("There is no user model save in secure storage");
      return null;
    }
  }

  Future<void> removeUserDetails() async {
    try {
      await _storage!.delete(key: userKey);
    } catch (e) {
      throw Exception(
        "Error on removing user details in secure storage\n Error : ${e.toString()}",
      );
    }
  }
}
