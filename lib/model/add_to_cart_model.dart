import 'dart:convert';

List<CartItem> cartFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  String? productId;
  String? productName;
  String? productImgUrl;
  int? productPrice;
  String? productCategory;
  int? quantity;
  int? oneItemPrice;

  CartItem({
    this.productId,
    this.productName,
    this.productImgUrl,
    this.productPrice,
    this.productCategory,
    this.quantity,
    this.oneItemPrice,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    if (json["productID"] is String) {
      productId = json["productID"];
    }
    if (json["productName"] is String) {
      productName = json["productName"];
    }
    if (json["productImgUrl"] is String) {
      productImgUrl = json["productImgUrl"];
    }
    if (json["productPrice"] is int) {
      productPrice = json["productPrice"];
    }
    if (json["productCategory"] is String) {
      productCategory = json["productCategory"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if (json["oneItemPrice"] is int) {
      oneItemPrice = json["oneItemPrice"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["productID"] = productId;
    _data["productName"] = productName;
    _data["productImgUrl"] = productImgUrl;
    _data["productPrice"] = productPrice;
    _data["productCategory"] = productCategory;
    _data["quantity"] = quantity;
    _data["oneItemPrice"] = oneItemPrice;

    return _data;
  }
}
