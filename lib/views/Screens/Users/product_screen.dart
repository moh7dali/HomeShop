import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/viewmodel/product_viewmodel.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({this.categoriyRule});
  String? categoriyRule;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      init: ProductViewModel(categoriyRule: ""),
      builder: (controller) {
        return Scaffold(
            body: controller.isLoad
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(controller.data[1]['productID'].toString())));
      },
    );
  }
}
