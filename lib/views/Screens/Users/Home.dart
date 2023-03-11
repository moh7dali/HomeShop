import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/views/Screens/Users/main_Screen.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/views/Screens/peronalPage/personalpage.dart';
import 'package:homeShop/views/Widgets/cart_icon_widget.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String username = "";
String img_url = "";
int selectedIndex = 0;
List<Widget> screen = [
  const MainScreen(),
  personalInfo(
    userId: FirebaseAuth.instance.currentUser!.uid,
  )
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        username = event['Fullname'];
        img_url = event['img'];
      });
    });
    return Scaffold(
      backgroundColor: backgroud,
      appBar: AppBar(
        iconTheme: IconThemeData(color: containerBackgroun),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(AssetsConstant.logo2, width: Get.width * .2),
        centerTitle: true,
        actions: [
          CartIcon(
            color: containerBackgroun,
          ),
          SizedBox(
            width: Get.width * .04,
          )
        ],
      ),
      body: screen.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: containerBackgroun,
        unselectedItemColor: Colors.black,
        selectedItemColor: backgroud,
        selectedLabelStyle: AppTheme.boldStyle(color: Colors.white, size: 13),
        unselectedLabelStyle: AppTheme.boldStyle(color: Colors.white, size: 13),
        selectedIconTheme: const IconThemeData(size: 20),
        unselectedIconTheme: const IconThemeData(size: 20),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: ImageIcon(AssetImage(AssetsConstant.home)),
            ),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ImageIcon(AssetImage(AssetsConstant.profile))),
            label: 'Profile'.tr,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            print(value);
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
