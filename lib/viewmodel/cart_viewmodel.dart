import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/model/add_to_cart_model.dart';
import 'package:homeShop/utils/shared_preference.dart';

class CartViewModel extends GetxController {
  TextEditingController instructionsController = TextEditingController();
  SharedPref shp = SharedPref();
  List<CartItem> cartData = [];
  int? finalAmount;
  int? subTotalLabel;
  int? constTotal;
  String? validationMsg;
  bool? isCorrect;
  bool isApplyClicked = false;
  bool isLoad = true;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    isLoad = true;
    getCartData();
  }

  getCartData() async {
    SharedPref shp = SharedPref();
    cartData = await shp.getCartModel();
    calculateFinalTotal();
    isLoad = false;
    update();
  }

  calculateFinalTotal() {
    int? subTotal = 0;
    cartData.forEach((element) {
      if (element.productOfferPrice != null && element.productOfferPrice != 0) {
        subTotal = subTotal! + element.productOfferPrice!;
      } else {
        subTotal = subTotal! + element.productPrice!;
      }
    });
    constTotal = subTotal;
    finalAmount = subTotal!;
    subTotalLabel = subTotal;
    update();
  }

  deleteOneItemFromCart(int id) async {
    int index = cartData
        .indexOf(cartData.firstWhere((element) => element.productId == id));
    SharedPref shp = SharedPref();
    await shp.deleteOneItemFromCart(index);
    isLoad = true;
    onInit();
    calculateFinalTotal();
    update();
  }

  deleteCartItems() async {
    SharedPref shp = SharedPref();
    shp.deleteAllCart();
    getCartData();
    update();
  }

  increaseCount(int id) async {
    int price = 0;
    CartItem accessItem =
        cartData.firstWhere((element) => element.productId == id);
    accessItem.quantity = accessItem.quantity! + 1;

    if (accessItem.oneItemOfferPrice != 0) {
      accessItem.productOfferPrice =
          ((accessItem.oneItemOfferPrice! + price) * accessItem.quantity!);
    } else if (accessItem.oneItemOfferPrice == 0) {
      accessItem.productPrice =
          (accessItem.oneItemPrice! + price) * accessItem.quantity!;
    }

    cartData[cartData.indexWhere((element) => element.productId == id)] =
        accessItem;
    shp.saveCart(cartData);
    calculateFinalTotal();
    update();
  }

  decreseCount(int id) async {
    int price = 0;
    CartItem accessItem =
        cartData.firstWhere((element) => element.productId == id);
    if (accessItem.quantity! > 1) {
      accessItem.quantity = accessItem.quantity! - 1;

      if (accessItem.productOfferPrice != 0) {
        accessItem.productOfferPrice =
            (accessItem.oneItemOfferPrice! + price) * accessItem.quantity!;
      } else {
        accessItem.productPrice =
            (accessItem.oneItemPrice! + price) * accessItem.quantity!;
      }

      cartData[cartData.indexWhere((element) => element.productId == id)] =
          accessItem;
      shp.saveCart(cartData);
    }

    calculateFinalTotal();
    update();
  }

  addOrder() async {
    update();
  }
}
