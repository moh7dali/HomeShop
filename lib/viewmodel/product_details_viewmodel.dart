import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:homeShop/model/add_to_cart_model.dart';
import 'package:homeShop/utils/shared_preference.dart';
import 'package:homeShop/viewmodel/cart_icon_viewmodel.dart';

class ProductDetailsViewModel extends GetxController {
  ProductDetailsViewModel({
    required this.productId,
  });
  String productId;
  Map<String, dynamic> data = {};
  bool isLoad = true;
  bool? hasOfferdPrice = false;
  int count = 1;
  int? price;
  int? offerPrice;
  int? fixedPrice;
  @override
  void onInit() {
    getProudectDetails(productId);
    super.onInit();
  }

  Future getProudectDetails(String productId) async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("products").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["productID"] == productId) {
          data.addAll(element.data());
          price = data['productPrice'];
          hasOfferdPrice = false;
          offerPrice = 0;
          fixedPrice = price;
        }
        update();
      });
    });
    isLoad = false;
    update();
  }

  incresePrice() {
    count++;
    price = fixedPrice! * count;
    offerPrice = fixedPrice! * count;
    update();
  }

  removePrice() {
    if (count > 1) {
      count--;
      price = fixedPrice! * count;
      offerPrice = fixedPrice! * count;
      update();
    }
  }

  CartItem? addToCartModel;
  SharedPref shp = SharedPref();
  addToCartMethod() async {
    List<CartItem> cartData = [];
    cartData = await shp.getCartModel();
    bool isProductExist = false;
    addToCartModel = CartItem(
        productId: data['productID'],
        productName: data['productName'],
        productImgUrl: data['productImgUrl'],
        productPrice: price,
        quantity: count,
        oneItemPrice: data['productPrice'],
        productCategory: data['productCategory']);

    cartData.forEach((element) {
      if (element.productId == addToCartModel!.productId) {
        print('productExist');
        isProductExist = true;
      } else {
        print('productNotExist');
        isProductExist = false;
      }
    });
    if (isProductExist) {
      final editCount = cartData.firstWhere(
          (element) => element.productId == addToCartModel!.productId);
      editCount.quantity = editCount.quantity! + 1;
    } else {
      print('Add new Product ');
      cartData.add(addToCartModel!);
    }
    update();
    shp.saveCart(cartData);
    if (Get.isRegistered<CartIconViewModel>()) {
      CartIconViewModel cartItemViewModel = Get.find<CartIconViewModel>();
      await cartItemViewModel.getCounter();
    }
    Get.back();
  }
}
