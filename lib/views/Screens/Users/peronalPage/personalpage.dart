import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/profile_viewmodel.dart';
import 'package:homeShop/views/Screens/Users/peronalPage/editProfile.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/views/Screens/language_screen.dart';

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
                            CircleAvatar(
                                radius: 50,
                                backgroundColor: containerBackgroun,
                                backgroundImage:
                                    NetworkImage(controller.imgUrl)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "UserName : ${controller.username}",
                                  style:
                                      AppTheme.lightStyle(color: Colors.white),
                                ),
                                Text(
                                  "Email : ${controller.email}",
                                  style:
                                      AppTheme.lightStyle(color: Colors.white),
                                ),
                                Text(
                                  "Phone : ${controller.phone}",
                                  style:
                                      AppTheme.lightStyle(color: Colors.white),
                                ),
                                Visibility(
                                  visible: controller.visibilty,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        minimumSize: Size(
                                            Get.width * .5, Get.height * .02),
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
                                          "Edit",
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
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                            onTap: () {},
                            title: Text(
                              "favorite product",
                              style: AppTheme.boldStyle(
                                  color: containerBackgroun, size: 18),
                            ),
                            leading: Image.asset(AssetsConstant.heart)),
                      ),
                      const Divider(color: iconColor),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                            onTap: () {},
                            title: Text(
                              "my Order",
                              style: AppTheme.boldStyle(
                                  color: containerBackgroun, size: 18),
                            ),
                            leading: Image.asset(AssetsConstant.pallete)),
                      ),
                      const Divider(color: iconColor),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                            onTap: () {
                              Get.to(const LanguageScreen());
                            },
                            title: Text(
                              "Change Language",
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
                              Navigator.popAndPushNamed(context, "Login");
                            },
                            title: Text(
                              "Log Out",
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
