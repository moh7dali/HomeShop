import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/cart_viewmodel.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget({
    this.id,
    this.prodTitle,
    this.itemPrice,
    this.offerPrice,
    this.totalPrice,
    this.totalOfferPrice,
    this.imgUrl,
    this.prodQuantity,
  });
  int? id;
  String? prodTitle;
  String? imgUrl;
  int? prodQuantity;
  int? itemPrice;
  int? offerPrice;
  int? totalPrice;
  int? totalOfferPrice;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(height: Get.height * .01),
            Row(
              children: [
                Image.network(
                  '$imgUrl',
                  width: Get.width * .25,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AssetsConstant.logo2,
                    width: Get.width * .25,
                  ),
                ),
                SizedBox(
                  width: Get.width * .5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${prodTitle ?? " "}'.tr,
                          style: AppTheme.boldStyle(
                              color: Colors.black, size: 16)),
                      Divider(
                        height: 20,
                        thickness: 2,
                        color: Colors.grey.withOpacity(.5),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('oneItemPrice'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.black, size: 16)),
                            offerPrice == 0 && offerPrice != null
                                ? Text('${itemPrice ?? 0.toStringAsFixed(2)}',
                                    style: AppTheme.boldStyle(
                                        color: Colors.black, size: 15))
                                : Row(
                                    children: [
                                      Text(
                                        '${itemPrice ?? 0.toStringAsFixed(2)} JD',
                                        style: AppTheme.boldStyle(
                                          color: containerBackgroun,
                                          size: 15,
                                        ).copyWith(
                                            decoration: offerPrice! > 0
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                      SizedBox(width: Get.width * .02),
                                      Text(
                                          '${offerPrice ?? 0.toStringAsFixed(2)} JD',
                                          style: AppTheme.boldStyle(
                                              color: Colors.red, size: 15)),
                                    ],
                                  )
                          ]),
                      Divider(
                        height: 20,
                        thickness: 2,
                        color: Colors.grey.withOpacity(.5),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('quantity'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.black, size: 16)),
                            Text('${prodQuantity ?? 0}'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.black, size: 16))
                          ]),
                      SizedBox(height: Get.height * .01),
                      Divider(
                        height: 20,
                        thickness: 2,
                        color: Colors.grey.withOpacity(.5),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('totalPrice'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.black, size: 16)),
                            totalOfferPrice == 0 || totalOfferPrice == null
                                ? Text(
                                    '${totalPrice ?? 0.toStringAsFixed(2)}'.tr,
                                    style: AppTheme.lightStyle(
                                        color: Colors.black, size: 16))
                                : Text(
                                    '${totalOfferPrice ?? 0.toStringAsFixed(2)}'
                                        .tr,
                                    style: AppTheme.lightStyle(
                                        color: Colors.black, size: 16))
                          ]),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.decreseCount(id!);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.black)),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 30,
                                    color: containerBackgroun,
                                  )),
                            ),
                            GestureDetector(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: Get.width * .1,
                                  decoration: BoxDecoration(
                                      color: containerBackgroun,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.black)),
                                  child: Text(
                                    "${prodQuantity}",
                                    style: AppTheme.boldStyle(
                                        color: Colors.white, size: 30),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.increaseCount(id!);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.black)),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: containerBackgroun,
                                  )),
                            )
                          ]),
                      SizedBox(height: Get.height * 0.01)
                    ],
                  ),
                ),
                SizedBox(width: Get.width * .05),
                GestureDetector(
                  onTap: () {
                    controller.deleteOneItemFromCart(id!);
                    // Helper().actionDialog(
                    //     confirm: () {
                    //       controller.deleteOneItemFromCart(id!);
                    //       Get.back();
                    //     },
                    //     cancel: () => Get.back(),
                    //     title: prodTitle,
                    //     body: "deleteConfirm".tr);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.close_sharp,
                        color: Colors.white,
                        size: 30,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
