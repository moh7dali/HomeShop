import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/viewmodel/product_viewmodel.dart';
import 'package:homeShop/views/Widgets/cart_icon_widget.dart';
import 'package:homeShop/views/Widgets/no_item_widget.dart';
import 'package:homeShop/views/Widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({this.categoriyRule});
  String? categoriyRule;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      init: ProductViewModel(categoriyRule: categoriyRule!),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: containerBackgroun,
            title: Text(categoriyRule!.tr),
            actions: [
              CartIcon(
                color: Colors.white,
              ),
              SizedBox(width: Get.width * .05),
            ],
          ),
          body: Column(
            children: [
              controller.isLoad
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            return await controller.init(categoriyRule!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.data.length == 0
                                ? NoItemWidget(
                                    title: "noproudects".tr,
                                    subTitle: "",
                                    imgUrl: AssetsConstant.noProduct,
                                    imgSize: 100,
                                  )
                                : ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.data.length,
                                    itemBuilder: (context, index) {
                                      return ProductCardWidget(
                                        isShop: false,
                                        productID: controller.data[index]
                                            ['productID'],
                                        productName: controller.data[index]
                                            ['productName'],
                                        productImgUrl: controller.data[index]
                                            ['productImgUrl'],
                                        productPrice: controller.data[index]
                                            ['productPrice'],
                                        productNameAr: controller.data[index]
                                            ['productNameAr'],
                                      );
                                    },
                                  ),
                          )),
                    ),
            ],
          ),
        );
      },
    );
  }
}
