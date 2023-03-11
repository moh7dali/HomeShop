import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/model/add_to_cart_model.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/my_orders_viewmodel.dart';
import 'package:homeShop/views/Widgets/cart_item_widget.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrdersViewModel>(
      init: MyOrdersViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("MyOrders".tr),
          backgroundColor: backgroud,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: controller.isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.allData.length,
                      itemBuilder: (context, index) {
                        List<CartItem> cartData = [];
                        cartData.addAll(cartFromJson(
                            controller.allData[index]['products']));
                        return Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: SizedBox(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${'orderId'.tr} :${controller.allData[index]['orderId']}",
                                          style: AppTheme.lightStyle(
                                              color: Colors.black),
                                        ),
                                        const Divider(
                                          color: iconColor,
                                        ),
                                        Text(
                                          "${'date'.tr} :${controller.allData[index]['date']}",
                                          style: AppTheme.lightStyle(
                                              color: Colors.black),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartData.length,
                              itemBuilder: (context, index1) {
                                return CartItemWidget(
                                  isCart: false,
                                  id: cartData[index1].productId,
                                  imgUrl: cartData[index1].productImgUrl,
                                  itemPrice: cartData[index1].oneItemPrice,
                                  totalPrice: cartData[index1].productPrice,
                                  prodTitle: cartData[index1].productName,
                                  prodQuantity: cartData[index1].quantity,
                                  prodTitleAr: cartData[index1].productNameAr,
                                );
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
