import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/cart_icon_viewmodel.dart';
import 'package:homeShop/views/Screens/Users/cart_screen.dart';

class CartIcon extends StatelessWidget {
  CartIcon({this.color});
  Color? color;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartIconViewModel>(
      init: CartIconViewModel(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(const CartScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: badges.Badge(
              showBadge: controller.count == 0 ? false : true,
              badgeContent: Text(
                "${controller.count}",
                style: AppTheme.boldStyle(color: Colors.white, size: 18),
              ),
              child: Image.asset(
                AssetsConstant.basketIcon,
                color: color,
                width: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
