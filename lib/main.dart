import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/views/Screens/Authentication/Company_signup.dart';
import 'package:homeShop/views/Screens/Authentication/Login.dart';
import 'package:homeShop/views/Screens/Authentication/signup.dart';
import 'package:homeShop/views/Screens/Company/AddNewJob.dart';
import 'package:homeShop/views/Screens/Company/AddNewTraining.dart';
import 'package:homeShop/views/Screens/Company/HomeCompany.dart';
import 'package:homeShop/views/Screens/Users/Home.dart';
import 'package:homeShop/views/Screens/Welcome.dart';
import 'package:homeShop/views/Screens/start.dart';
import 'package:homeShop/views/Widgets/splash_screen.dart';
import 'views/Screens/Authentication/ForgetPass.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    theme: ThemeData(brightness: Brightness.light),
    debugShowCheckedModeBanner: false,
    routes: {
      "Login": (context) => Login(),
      "Sign_Up": (context) => Sign_up(),
      "Check": (context) => const SplashScreen(),
      "Company Sign up": (context) => Company_Sign_up(),
      "Home": (context) => Home(),
      "Start": (context) => const Start_page(),
      "forgetpassword": (context) => const ForgetPassword(),
      "welcome": (context) => Welcome(),
      "companyHome": (context) => CompanyHome(),
      "addNewJob": (context) => AddNewJob(),
      "addNewTraining": (context) => AddNewTraining(),
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
