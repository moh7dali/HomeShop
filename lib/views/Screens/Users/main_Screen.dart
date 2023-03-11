import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/views/Screens/Users/product_screen.dart';
import 'package:homeShop/views/Widgets/sectionscard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("LetsMakeaGreatDeal".tr,
                      style: GoogleFonts.nunito(
                        fontSize: titleSize,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SectionsCard(
                    OnTapping: () {
                      Get.to(ProductScreen(
                        categoriyRule: "food",
                      ));
                    },
                    CardTitle: "food".tr,
                    CardSubTitle: "",
                    ImageName: AssetsConstant.food,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SectionsCard(
                    OnTapping: () {
                      Get.to(ProductScreen(
                        categoriyRule: "homeAccessories",
                      ));
                    },
                    CardTitle: "homeAccessories".tr,
                    CardSubTitle: "",
                    ImageName: AssetsConstant.candles,
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SectionsCard(
                    OnTapping: () {
                      Get.to(ProductScreen(
                        categoriyRule: "Clothes",
                      ));
                    },
                    CardTitle: "Clothes".tr,
                    CardSubTitle: "",
                    ImageName: AssetsConstant.hoodie,
                    width: Get.width * .5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SectionsCard(
                    OnTapping: () {
                      Get.to(ProductScreen(
                        categoriyRule: "electronicAccessories",
                      ));
                    },
                    CardTitle: "electronicAccessories".tr,
                    CardSubTitle: "",
                    ImageName: AssetsConstant.gamer,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
