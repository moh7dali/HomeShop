import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeShop/views/Screens/Company/home_company_screen.dart';
import 'package:homeShop/views/Screens/Users/Home.dart';
import 'package:homeShop/views/Screens/start.dart';

class SplashViewModel extends GetxController with WidgetsBindingObserver {
  bool isAnimated = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    isAnimated = true;
    update();
    Future.delayed(const Duration(seconds: 2), () async {
      isAnimated = false;
      update();
      await getSecondScreen();
    });
    super.onInit();
  }

  String? type;
  Future<void> getSecondScreen() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        type = value['rules'];
        print(type);
        print("+++++++++++++++++");
        update();
      });
      if (type != null) {
        if (type == "User") {
          Get.offAll(Home());
        } else if (type == "shop") {
          Get.offAll(HomeCompany());
        }
      } else {
        Get.offAll(Start_page());
      }
    } else {
      Get.offAll(Start_page());
    }
    update();
  }
}
