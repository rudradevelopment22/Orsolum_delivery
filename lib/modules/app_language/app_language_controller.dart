import 'package:get/get.dart';

class AppLanguageController extends GetxController {
  final RxString selectedLanguage = 'English'.obs;
  final List<String> languages = [
    "English",
    "Hindi",
    "Telugu",
    "Tamil",
    "Kannada",
    "Bengali",
  ];

  void updateLanguage(String language) {
    selectedLanguage.value = language;
  }
}
