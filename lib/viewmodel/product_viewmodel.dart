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
    init(categoriyRule);
    super.onInit();
  }

  Future init(String categoriyRule) async {
    isLoad = true;
    data = [];
    print(categoriyRule);
    getProduct(categoriyRule);
  }

  Future getProduct(String categoriyRule) async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("products").get().then((value) {
      value.docs.forEach((element) {
        print("__________");
        print(element.data()['productCategory']);
        if (element.data()['productCategory'] == categoriyRule) {
          print(element.data());
          data.add(element.data());
        }
        update();
      });
    });
    isLoad = false;
    update();
  }
}
