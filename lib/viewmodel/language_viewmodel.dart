import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/main.dart';
import 'package:homeShop/utils/shared_preference.dart';
import 'package:homeShop/views/Screens/Users/Home.dart';

class LanguageViewModel extends GetxController {
  SharedPref shp = SharedPref();
  updateLanguage(String lang) {
    appLanguage = lang;
    shp.saveLanguage(lang);
    Get.updateLocale(Locale(lang));
    Get.deleteAll();
    Get.offAll(Home());
    update();
  }
}
