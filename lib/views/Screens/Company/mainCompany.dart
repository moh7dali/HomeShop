import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/viewmodel/home_company_viewmodel.dart';
import 'package:homeShop/views/Screens/Company/add_product_screen.dart';
import 'package:homeShop/views/Widgets/drawer.dart';
import 'package:homeShop/views/Widgets/no_item_widget.dart';
import 'package:homeShop/views/Widgets/product_card.dart';

import '../language_screen.dart';

class HomeCompany extends StatelessWidget {
  const HomeCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCompanyViewModel>(
      init: HomeCompanyViewModel(),
      builder: (controller) {
        return Scaffold(
            body: Column(
              children: [
                controller.isLoad
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: RefreshIndicator(
                            onRefresh: () async {
                              return await controller.init();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  controller.data.length == 0
                                      ? NoItemWidget(
                                          title: "noproudects".tr,
                                          subTitle: "",
                                          imgUrl: AssetsConstant.noProduct,
                                          imgSize: 150,
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.data.length,
                                          itemBuilder: (context, index) {
                                            return ProductCardWidget(
                                              isShop: true,
                                              productID: controller.data[index]
                                                  ['productID'],
                                              productName: controller
                                                  .data[index]['productName'],
                                              productImgUrl: controller
                                                  .data[index]['productImgUrl'],
                                              productPrice: controller
                                                  .data[index]['productPrice'],
                                              productNameAr: controller
                                                  .data[index]['productNameAr'],
                                              productCategory:
                                                  controller.data[index]
                                                      ['productCategory'],
                                              edit: () {
                                                print("edit clicked");
                                                Get.to(AddProductScreen(
                                                  productId: controller
                                                      .data[index]['productID'],
                                                ));
                                              },
                                              delete: () async {
                                                print("delete clicked");
                                                await controller.deleteProduct(
                                                    controller.data[index]
                                                        ['productID']);
                                              },
                                            );
                                          },
                                        ),
                                ],
                              ),
                            )),
                      ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: containerBackgroun,
              onPressed: () {},
              child: IconButton(
                onPressed: () {
                  Get.to(AddProductScreen(
                    productId: null,
                  ));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                color: Colors.white,
              ),
            ));
      },
    );
  }
}
