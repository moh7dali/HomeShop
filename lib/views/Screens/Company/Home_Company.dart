import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/views/Screens/Company/mainCompany.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/views/Screens/peronalPage/personalpage.dart';
import 'package:homeShop/views/Widgets/cart_icon_widget.dart';

class HOME_Company extends StatefulWidget {
  HOME_Company({super.key});

  @override
  State<HOME_Company> createState() => _HOME_CompanyState();
}

String username = "";
String img_url = "";
int selectedIndex = 0;
List<Widget> screen = [
  HomeCompany(),
  personalInfo(
    userId: FirebaseAuth.instance.currentUser!.uid,
  )
];

class _HOME_CompanyState extends State<HOME_Company> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroud,
      appBar: AppBar(
        iconTheme: IconThemeData(color: containerBackgroun),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(AssetsConstant.logo2, width: Get.width * .2),
        centerTitle: true,
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
