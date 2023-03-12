import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/users_order_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class UserOrders extends StatelessWidget {
  UserOrders({this.prodId});
  String? prodId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersOrderViewModel>(
      init: UsersOrderViewModel(prodId: prodId!),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: controller.isLoad
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: containerBackgroun,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.userData[index]
                                              ['img'] ??
                                          '',
                                      fit: BoxFit.fitHeight,
                                      width: Get.width * .3,
                                      height: Get.height * .15,
                                      placeholder: (w, e) => Image.asset(
                                        AssetsConstant.loading,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (c, e, s) => Image.asset(
                                        AssetsConstant.logo2,
                                        width: Get.width * .3,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${controller.userData[index]['Fullname']}",
                                      style: AppTheme.boldStyle(
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (!await launchUrl(
                                          Uri.parse(controller.userData[index]
                                              ['facebookUrl']),
                                          mode:
                                              LaunchMode.externalApplication)) {
                                        throw 'Could not launch ${controller.userData[index]['facebookUrl']}';
                                      }
                                    },
                                    child: Image.asset(
                                      AssetsConstant.facebook,
                                      width: Get.width * .1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (!await launchUrl(
                                          Uri.parse(controller.userData[index]
                                              ['instgramUrl']),
                                          mode:
                                              LaunchMode.externalApplication)) {
                                        throw 'Could not launch ${controller.userData[index]['instgramUrl']}';
                                      }
                                    },
                                    child: Image.asset(
                                      AssetsConstant.instgram,
                                      width: Get.width * .1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (!await launchUrl(
                                          Uri.parse(controller.userData[index]
                                              ['whatsappUrl']),
                                          mode:
                                              LaunchMode.externalApplication)) {
                                        throw 'Could not launch ${controller.userData[index]['whatsappUrl']}';
                                      }
                                    },
                                    child: Image.asset(
                                      AssetsConstant.whatsapp,
                                      width: Get.width * .1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (!await launchUrl(
                                          Uri.parse(
                                              "tel:${controller.userData[index]['phone']}"),
                                          mode:
                                              LaunchMode.externalApplication)) {
                                        throw 'Could not launch ${controller.userData[index]['phone']}';
                                      }
                                    },
                                    child: Image.asset(
                                      AssetsConstant.phone,
                                      width: Get.width * .1,
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
