import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/viewmodel/product_viewmodel.dart';
import 'package:homeShop/views/Screens/Users/cart_screen.dart';
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
            title: Text(categoriyRule!),
            leading: GestureDetector(
                onTap: () => Get.to(CartScreen()),
                child: Icon(Icons.add_shopping_cart)),
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
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.data.length,
                              itemBuilder: (context, index) {
                                return ProductCardWidget(
                                  productID: controller.data[index]
                                      ['productID'],
                                  productName: controller.data[index]
                                      ['productName'],
                                  productImgUrl: controller.data[index]
                                      ['productImgUrl'],
                                  productPrice: controller.data[index]
                                      ['productPrice'],
                                  productOfferPrice: controller.data[index]
                                      ['productOfferPrice'],
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
