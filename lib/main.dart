import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/shared_preference.dart';
import 'package:homeShop/utils/translation/translate.dart';
import 'package:homeShop/views/Screens/Authentication/Company_signup.dart';
import 'package:homeShop/views/Screens/Authentication/Login.dart';
import 'package:homeShop/views/Screens/Authentication/signup.dart';
import 'package:homeShop/views/Screens/Users/Home.dart';
import 'package:homeShop/views/Screens/start.dart';
import 'package:homeShop/views/Widgets/splash_screen.dart';
import 'views/Screens/Authentication/ForgetPass.dart';
import 'firebase_options.dart';

String appLanguage = 'en';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPref prefs = SharedPref();
  appLanguage = await prefs.getLanguage() ?? 'en';
  runApp(GetMaterialApp(
    translations: Tranlation(),
    locale: Locale(appLanguage),
    fallbackLocale: Locale(appLanguage),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    routes: {
      "Login": (context) => Login(),
      "Sign_Up": (context) => Sign_up(),
      "Check": (context) => const SplashScreen(),
      "Company Sign up": (context) => Company_Sign_up(),
      "Home": (context) => Home(),
      "Start": (context) => const Start_page(),
      "forgetpassword": (context) => const ForgetPassword(),
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
