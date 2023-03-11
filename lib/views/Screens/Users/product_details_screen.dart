import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/main.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/product_details_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({this.productId});
  String? productId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsViewModel>(
        init: ProductDetailsViewModel(productId: productId!),
        builder: (controller) => controller.isLoad
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                backgroundColor: backgroud,
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: Text(
                    appLanguage == 'en'
                        ? controller.data['productName']
                        : controller.data['productNameAr'],
                    style: AppTheme.lightStyle(color: Colors.white, size: 17),
                  ),
                  backgroundColor: containerBackgroun,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Image.network(
                                              '${controller.data['productImgUrl']}',
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      AssetsConstant.logo2)),
                                        ));
                              },
                              child: CachedNetworkImage(
                                imageUrl:
                                    controller.data['productImgUrl'] ?? '',
                                fit: BoxFit.cover,
                                width: Get.width * .4,
                                //height: Get.height * .5,
                                placeholder: (w, e) => Image.asset(
                                  AssetsConstant.loading,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (c, e, s) =>
                                    Image.asset(AssetsConstant.logo2),
                              ),
                            ),
                            Text(
                              appLanguage == 'en'
                                  ? "${controller.data['productName'] ?? " "}"
                                  : "${controller.data['productNameAr'] ?? " "}",
                              style: AppTheme.boldStyle(
                                  color: Colors.black, size: 20),
                            ),
                            SizedBox(height: Get.height * .01),
                            Text("${controller.data['productPrice'] ?? " "} JD",
                                style: AppTheme.boldStyle(
                                    color: containerBackgroun, size: 20)),
                            SizedBox(height: Get.height * .02),
                            Divider(color: iconColor),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Quantity",
                                      style: AppTheme.lightStyle(
                                          color: Colors.black, size: 20),
                                    )),
                                SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: containerBackgroun),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              controller.incresePrice();
                                            },
                                            child: Text(
                                              "+",
                                              style: AppTheme.lightStyle(
                                                  color: Colors.white,
                                                  size: 20),
                                            )),
                                        Container(
                                          height: Get.height * .05,
                                          width: Get.width * .1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.white,
                                          ),
                                          child: Text("${controller.count}",
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black)),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              controller.removePrice();
                                            },
                                            child: Text(
                                              "-",
                                              style: AppTheme.lightStyle(
                                                  color: Colors.white,
                                                  size: 20),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Get.height * .02),
                            Divider(color: iconColor),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Shop Info :- ",
                                  style: AppTheme.lightStyle(
                                      color: Colors.black, size: 20),
                                )),
                            SizedBox(height: Get.height * .02),
                            Text(
                              "${controller.shopName}",
                              style: AppTheme.lightStyle(
                                  color: Colors.black, size: 20),
                            ),
                            SizedBox(height: Get.height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (!await launchUrl(
                                        Uri.parse(controller.faceBook!),
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch ${controller.faceBook!}';
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
                                        Uri.parse(controller.instgram!),
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch ${controller.instgram!}';
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
                                        Uri.parse(controller.whatsApp!),
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch ${controller.whatsApp!}';
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
                                        Uri.parse("tel:${controller.phone!}"),
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch ${controller.faceBook!}';
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
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize:
                                  Size(Get.width * .3, Get.height * .07),
                              backgroundColor: containerBackgroun),
                          onPressed: () {
                            controller.addToCartMethod();
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add To Cart".tr,
                                  style: AppTheme.lightStyle(
                                      color: Colors.white, size: 25),
                                ),
                                Text(
                                  "${controller.price} JD",
                                  style: AppTheme.lightStyle(
                                      color: Colors.white, size: 25),
                                )
                              ])),
                      SizedBox(height: Get.height * .01)
                    ],
                  ),
                ),
              ));
  }
}
