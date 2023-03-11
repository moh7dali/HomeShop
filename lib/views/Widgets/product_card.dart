import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/main.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:homeShop/views/Screens/Users/product_details_screen.dart';
import 'package:flutter/cupertino.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget(
      {this.productID,
      this.productName,
      this.productNameAr,
      this.productPrice,
      this.productImgUrl,
      this.isShop,
      this.delete,
      this.edit});
  String? productID;
  String? productImgUrl;
  String? productName;
  String? productNameAr;
  int? productPrice;
  bool? isShop;
  Function? edit;
  Function? delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          isShop!
              ? Get.dialog(
                  CupertinoAlertDialog(
                    title: Text(
                      productName.toString().toUpperCase(),
                      style: const TextStyle(
                        fontSize: titleSize,
                      ),
                    ),
                    content: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: containerBackgroun,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "title in englis",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: subTitleSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productName!,
                            style: const TextStyle(
                              fontSize: ParagraphSize,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: containerBackgroun,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "price",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: subTitleSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productPrice!.toString(),
                            style: const TextStyle(
                              fontSize: ParagraphSize,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            edit!();
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: subTitleSize,
                              color: Colors.black,
                            ),
                          )),
                      TextButton(
                        onPressed: () async {
                          delete!();
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: subTitleSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Get.to(ProductDetails(productId: productID));
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * .5,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          appLanguage == 'en'
                              ? '${productName}'
                              : '$productNameAr',
                          style: AppTheme.lightStyle(
                              color: Colors.black, size: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text('${productPrice}JD',
                                style: AppTheme.lightStyle(
                                    color: containerBackgroun, size: 18)),
                          ),
                        ],
                      ),
                    ]),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: productImgUrl ?? '',
                    fit: BoxFit.fitHeight,
                    width: Get.width,
                    height: Get.height * .15,
                    placeholder: (w, e) => Image.asset(
                      AssetsConstant.loading,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (c, e, s) => Image.asset(AssetsConstant.logo2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
