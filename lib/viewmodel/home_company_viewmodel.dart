import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeCompanyViewModel extends GetxController {
  bool isLoad = true;
  List<Map<String, dynamic>> data = [];
  @override
  void onInit() {
    print(FirebaseAuth.instance.currentUser!.uid);
    getProduct();
    super.onInit();
  }

  Future init() async {
    isLoad = true;
    data = [];
    getProduct();
  }

  Future getProduct() async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("products").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['shopID'] ==
            FirebaseAuth.instance.currentUser!.uid) {
          data.add(element.data());
        }
        update();
      });
    });
    isLoad = false;
    update();
  }

  String? docID;
  Future deleteProduct(String id) async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("products").get().then(
      (value) {
        docID = value.docs
            .firstWhere((element) => element.get("productID") == id)
            .id;
      },
    );
    await FirebaseFirestore.instance
        .collection("products")
        .doc(docID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
    init();
    Get.back();
    update();
  }
}
