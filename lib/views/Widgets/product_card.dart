import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:homeShop/views/Screens/Users/product_details_screen.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget(
      {this.productID,
      this.productName,
      this.productPrice,
      this.productImgUrl,
      this.productOfferPrice});
  int? productID;
  String? productImgUrl;
  String? productName;
  int? productOfferPrice;
  int? productPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(ProductDetails(productId: productID));
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
                      Text('${productName}',
                          style: AppTheme.lightStyle(
                              color: Colors.black, size: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              '${productPrice}JD',
                              style: AppTheme.lightStyle(
                                      color: containerBackgroun, size: 18)
                                  .copyWith(
                                      decoration: productOfferPrice! > 0
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                            ),
                          ),
                          if (productOfferPrice! > 0)
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${productOfferPrice}JD',
                                  style: AppTheme.lightStyle(
                                      color: Colors.red, size: 18),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ]),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: productImgUrl ?? '',
                    fit: BoxFit.fitWidth,
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
