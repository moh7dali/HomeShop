import 'package:get/get.dart';
import 'package:homeShop/model/add_to_cart_model.dart';
import 'package:homeShop/utils/shared_preference.dart';

class CartIconViewModel extends GetxController {
  @override
  void onInit() {
    getCounter();
    super.onInit();
  }

  List<CartItem> cartData = [];
  int? count;
  getCounter() async {
    count = 0;
    SharedPref shp = SharedPref();
    cartData = await shp.getCartModel();
    cartData.forEach((element) {
      count = count! + element.quantity!;
    });
    update();
  }
}
