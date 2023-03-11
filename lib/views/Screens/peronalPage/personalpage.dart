import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/profile_viewmodel.dart';
import 'package:homeShop/views/Screens/Users/my_orders_screen.dart';
import 'package:homeShop/views/Screens/peronalPage/editProfile.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/views/Screens/language_screen.dart';
import 'package:homeShop/views/Widgets/splash_screen.dart';

class personalInfo extends StatelessWidget {
  personalInfo({this.userId});
  String? userId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: backgroud,
          body: controller.isLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: containerBackgroun,
                        width: Get.width,
                        height: Get.height * .2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: controller.imgUrl,
                                  fit: BoxFit.fitHeight,
                                  width: Get.width,
                                  height: Get.height * .15,
                                  placeholder: (w, e) => Image.asset(
                                    AssetsConstant.loading,
                                    fit: BoxFit.fitHeight,
                                    width: Get.width * .5,
                                  ),
                                  errorWidget: (c, e, s) => Image.asset(
                                    AssetsConstant.logo2,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "UserName".tr,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      controller.username,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Email".tr,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      controller.email,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Phone".tr,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      controller.phone,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: controller.visibilty,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        minimumSize: Size(
                                            Get.width * .4, Get.height * .02),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return editProfile();
                                      }));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AssetsConstant.edit,
                                          width: Get.width * .1,
                                        ),
                                        SizedBox(width: Get.width * .1),
                                        Text(
                                          "Edit".tr,
                                          style: AppTheme.lightStyle(
                                              color: containerBackgroun),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // Visibility(
                      //   visible: controller.userType == 'User',
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: Column(
                      //       children: [
                      //         ListTile(
                      //             onTap: () {},
                      //             title: Text(
                      //               "favoriteproduct".tr,
                      //               style: AppTheme.boldStyle(
                      //                   color: containerBackgroun, size: 18),
                      //             ),
                      //             leading: Image.asset(AssetsConstant.heart)),
                      //         const Divider(color: iconColor),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Visibility(
                        visible: controller.userType == 'User',
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              ListTile(
                                  onTap: () {
                                    Get.to(MyOrdersScreen());
                                  },
                                  title: Text(
                                    "myOrder".tr,
                                    style: AppTheme.boldStyle(
                                        color: containerBackgroun, size: 18),
                                  ),
                                  leading: Image.asset(AssetsConstant.pallete)),
                              const Divider(color: iconColor),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                            onTap: () {
                              Get.to(const LanguageScreen());
                            },
                            title: Text(
                              "ChangeLanguage".tr,
                              style: AppTheme.boldStyle(
                                  color: containerBackgroun, size: 18),
                            ),
                            leading: Image.asset(AssetsConstant.translation)),
                      ),
                      const Divider(color: iconColor),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Get.to(SplashScreen());
                              // Navigator.popAndPushNamed(context, "Login");
                            },
                            title: Text(
                              "LogOut".tr,
                              style: AppTheme.boldStyle(
                                  color: containerBackgroun, size: 18),
                            ),
                            leading: Image.asset(AssetsConstant.logout)),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
