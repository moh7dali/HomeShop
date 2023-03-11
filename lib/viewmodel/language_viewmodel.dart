import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/main.dart';
import 'package:homeShop/utils/shared_preference.dart';
import 'package:homeShop/viewmodel/splash_viewmodel.dart';
import 'package:homeShop/views/Widgets/splash_screen.dart';

class LanguageViewModel extends GetxController {
  SharedPref shp = SharedPref();
  updateLanguage(String lang) async {
    appLanguage = lang;
    shp.saveLanguage(lang);
    Get.updateLocale(Locale(lang));
    Get.deleteAll();
    Get.to(SplashScreen());
    SplashViewModel splashViewModel = SplashViewModel();
    await splashViewModel.getSecondScreen();
    update();
  }
}
