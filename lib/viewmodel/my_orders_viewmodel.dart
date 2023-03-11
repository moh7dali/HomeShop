import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homeShop/model/add_to_cart_model.dart';

class MyOrdersViewModel extends GetxController {
  List<Map<String, dynamic>> allData = [];
  //List<CartItem> cartData = [];
  int length = 0;
  bool isLoad = true;
  @override
  void onInit() {
    getUserOrder();
    super.onInit();
  }

  Future getUserOrder() async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("Orders").get().then((value) {
      value.docs.forEach((element) {
        if (element.get('userId') == FirebaseAuth.instance.currentUser!.uid) {
          allData.add(element.data());
          length = cartFromJson(element.get('products')).length;
          print("((((((((((${length}))))))))))");
          // cartData.addAll(cartFromJson(element.get('products')));
          //print("((((((((((${cartData}))))))))))");
        }
        update();
      });
    });
    isLoad = false;
    update();
  }
}
