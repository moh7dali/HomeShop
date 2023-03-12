// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:homeShop/model/add_to_cart_model.dart';

class UsersOrderViewModel extends GetxController {
  List<CartItem> cartData = [];
  bool isLoad = true;
  bool? hasOrder;
  List<String> userId = [];
  List<Map<String, dynamic>> userData = [];
  String prodId;
  UsersOrderViewModel({
    required this.prodId,
  });
  @override
  void onInit() {
    getUserOrders(prodId);
    super.onInit();
  }

  Future getUserOrders(String prodId) async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("Orders").get().then((value) {
      value.docs.forEach((element) {
        cartData.addAll(cartFromJson(element.get('products')));
        userId.add(element.get('userId'));
      });
    });
    cartData.forEach((element) {
      if (element.productId == prodId) {
        hasOrder = true;
      } else {
        hasOrder = false;
      }
    });
    if (hasOrder!) {
      final db = FirebaseFirestore.instance;
      final docRef = await db.collection("Users").get().then((value) {
        userId.forEach((elementId) {
          value.docs.forEach((element) {
            if (element.get('user_id') == elementId) {
              userData.add(element.data());
            }
          });
        });
      });
    }
    isLoad = false;
    update();
  }
}
