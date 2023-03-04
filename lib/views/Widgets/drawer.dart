import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/views/Screens/Users/Home.dart';
import 'package:homeShop/views/Screens/language_screen.dart';

class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: containerBackgroun,
      child: ListView(children: [
        ListTile(
          leading: Image.asset(
            AssetsConstant.home,
            height: 45,
            color: Colors.white,
          ),
          title: Text(
            "altahonehMain".tr,
            style: AppTheme.boldStyle(color: Colors.white, size: 19),
          ),
          onTap: () => Get.to(Home()),
        ),
        ListTile(
          leading: Image.asset(
            AssetsConstant.home,
            height: 45,
            color: Colors.white,
          ),
          title: Text(
            "Language".tr,
            style: AppTheme.boldStyle(color: Colors.white, size: 19),
          ),
          onTap: () => Get.to(const LanguageScreen()),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.popAndPushNamed(context, "Login");
          },
          title: Text(
            "Log Out".tr,
            style: AppTheme.boldStyle(color: Colors.white, size: 19),
          ),
        )
      ]),
    );
  }
}
