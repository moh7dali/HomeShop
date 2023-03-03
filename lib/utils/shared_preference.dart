import 'package:homeShop/model/add_to_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? prefs;
  saveCart(List<CartItem> cartItemModel) async {
    print("******");
    print(cartToJson(cartItemModel));
    print("******");
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("cartData", cartToJson(cartItemModel));
  }

  Future<List<CartItem>> getCartModel() async {
    List<CartItem> cartDataModel;
    prefs = await SharedPreferences.getInstance();
    String? str = prefs!.getString("cartData");
    if (str != null) {
      print("******");
      print(str);
      print("******");
      cartDataModel = cartFromJson(str);
    } else {
      cartDataModel = [];
    }

    return cartDataModel;
  }

  Future deleteOneItemFromCart(int index) async {
    List<CartItem> cartData = [];
    cartData = await getCartModel();
    cartData.removeAt(index);
    saveCart(cartData);
  }

  deleteAllCart() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove("cartData");
  }
}
