// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  bool isLoad = true;
  List<Map<String, dynamic>> data = [];
  String categoriyRule;
  ProductViewModel({
    required this.categoriyRule,
  });
  @override
  void onInit() {
    getProduct();
    super.onInit();
  }

  Future getProduct() async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("products").get().then((value) {
      value.docs.forEach((element) {
        data.add(element.data());
        update();
      });
    });
    print("++++++++++++++++++++++++++++++");
    //print(data);
    print("++++++++++++++++++++++++++++++");
    isLoad = false;
    update();
  }
}
