import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/model/add_to_cart_model.dart';
import 'package:homeShop/utils/shared_preference.dart';
import 'package:homeShop/viewmodel/cart_icon_viewmodel.dart';
import 'package:homeShop/views/Screens/Users/Home.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CartViewModel extends GetxController {
  TextEditingController instructionsController = TextEditingController();
  SharedPref shp = SharedPref();
  List<CartItem> cartData = [];
  int? finalAmount;
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
      subTotal = subTotal! + element.productPrice!;
    });
    finalAmount = subTotal;
    update();
  }

  deleteOneItemFromCart(String id) async {
    int index = cartData
        .indexOf(cartData.firstWhere((element) => element.productId == id));
    SharedPref shp = SharedPref();
    await shp.deleteOneItemFromCart(index);
    isLoad = true;
    onInit();
    if (Get.isRegistered<CartIconViewModel>()) {
      CartIconViewModel cartItemViewModel = Get.find<CartIconViewModel>();
      await cartItemViewModel.getCounter();
    }
    calculateFinalTotal();
    update();
  }

  deleteCartItems() async {
    SharedPref shp = SharedPref();
    shp.deleteAllCart();
    getCartData();
    if (Get.isRegistered<CartIconViewModel>()) {
      CartIconViewModel cartItemViewModel = Get.find<CartIconViewModel>();
      await cartItemViewModel.getCounter();
    }
    update();
  }

  increaseCount(String id) async {
    int price = 0;
    CartItem accessItem =
        cartData.firstWhere((element) => element.productId == id);

    accessItem.quantity = accessItem.quantity! + 1;

    accessItem.productPrice =
        (accessItem.oneItemPrice! + price) * accessItem.quantity!;

    cartData[cartData.indexWhere((element) => element.productId == id)] =
        accessItem;
    update();
    shp.saveCart(cartData);
    if (Get.isRegistered<CartIconViewModel>()) {
      CartIconViewModel cartItemViewModel = Get.find<CartIconViewModel>();
      await cartItemViewModel.getCounter();
    }
    calculateFinalTotal();
    update();
  }

  decreseCount(String id) async {
    int price = 0;
    CartItem accessItem =
        cartData.firstWhere((element) => element.productId == id);
    if (accessItem.quantity! > 1) {
      accessItem.quantity = accessItem.quantity! - 1;

      accessItem.productPrice =
          (accessItem.oneItemPrice! + price) * accessItem.quantity!;

      cartData[cartData.indexWhere((element) => element.productId == id)] =
          accessItem;
      shp.saveCart(cartData);
    }
    if (Get.isRegistered<CartIconViewModel>()) {
      CartIconViewModel cartItemViewModel = Get.find<CartIconViewModel>();
      await cartItemViewModel.getCounter();
    }
    calculateFinalTotal();
    update();
  }

  addOrder() async {
    var uuid = Uuid();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now);
    FirebaseFirestore.instance.collection('Orders').add({
      "orderId": uuid.v1(),
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "products": cartToJson(cartData),
      "date": formattedDate,
      "specialInstructions": instructionsController.text
    });
    deleteCartItems();
    Get.offAll(Home());
    update();
  }
}
