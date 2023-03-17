import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/main.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/cart_viewmodel.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget(
      {this.id,
      this.prodTitle,
      this.itemPrice,
      this.totalPrice,
      this.imgUrl,
      this.prodQuantity,
      this.prodTitleAr,
      this.increaseCount,
      this.decreseCount,
      this.deleteOneITem,
      this.isCart});
  String? id;
  String? prodTitle;
  String? imgUrl;
  int? prodQuantity;
  int? itemPrice;
  int? totalPrice;
  String? prodTitleAr;
  Function? increaseCount;
  Function? decreseCount;
  Function? deleteOneITem;
  bool? isCart;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl ?? '',
                    fit: BoxFit.fitHeight,
                    width: Get.width * .25,
                    placeholder: (w, e) => Image.asset(
                      AssetsConstant.loading,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (c, e, s) => Image.asset(AssetsConstant.logo2),
                  ),
                ),
              ),
              SizedBox(width: 5),
              SizedBox(
                width: Get.width * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text('ProdactTitle'.tr,
                            style: AppTheme.boldStyle(
                                color: Colors.black, size: 16)),
                        Text(
                            appLanguage == 'en' ? '$prodTitle' : '$prodTitleAr',
                            style: AppTheme.lightStyle(
                                color: Colors.black, size: 16))
                      ],
                    ),
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
                          Text('${itemPrice ?? 0.toStringAsFixed(2)}',
                              style: AppTheme.boldStyle(
                                  color: Colors.black, size: 15))
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
                          Text('${totalPrice ?? 0.toStringAsFixed(2)}'.tr,
                              style: AppTheme.lightStyle(
                                  color: Colors.black, size: 16))
                        ]),
                    SizedBox(height: Get.height * 0.01),
                    Visibility(
                      visible: isCart!,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                decreseCount!();
                                //controller.decreseCount(id!);
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
                                increaseCount!();
                                //controller.increaseCount(id!);
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
                    ),
                    SizedBox(height: Get.height * 0.01)
                  ],
                ),
              ),
              SizedBox(width: Get.width * .05),
              Visibility(
                visible: isCart!,
                child: GestureDetector(
                  onTap: () {
                    deleteOneITem!();
                    //controller.deleteOneItemFromCart(id!);
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
