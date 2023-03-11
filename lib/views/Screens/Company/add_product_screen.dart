import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/viewmodel/add_proudect_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({this.productId});
  String? productId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductViewModel>(
        init: AddProductViewModel(productId: productId),
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: ListView(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height * .3,
                      child: controller.pickedimg == null
                          ? controller.imgUrl == null
                              ? Image.asset(AssetsConstant.logo)
                              : Image.network(controller.imgUrl!)
                          : Image.file(
                              controller.pickedimg!,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text("ChooseimageFrom?".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  controller.funimg(ImageSource.gallery),
                              icon: Icon(Ionicons.folder),
                            ),
                            IconButton(
                              onPressed: () =>
                                  controller.funimg(ImageSource.camera),
                              icon: Icon(
                                Ionicons.camera,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Ionicons.text_outline),
                          labelText: 'prouductnameinenglish'.tr,
                          hintText: 'prouductnameinenglish'.tr,
                          border: OutlineInputBorder()),
                      controller: controller.englisNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Ionicons.document_text_outline),
                          labelText: 'prouductnameinarabic'.tr,
                          hintText: 'prouductnameinarabic'.tr,
                          border: OutlineInputBorder()),
                      controller: controller.arabicNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Ionicons.calendar_outline),
                          labelText: 'productPrice'.tr,
                          hintText: 'productPrice'.tr,
                          border: OutlineInputBorder()),
                      controller: controller.priceController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      items: controller.productCategory.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.tr),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.getProductCategory(value);
                      },
                      value: controller.selectedProductCategory,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Ionicons.link_outline),
                          labelText: 'productCategory'.tr,
                          hintText: 'productCategory'.tr,
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: containerBackgroun,
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 15)),
                      onPressed: () async {
                        await controller.addProduct(productId: productId);
                      },
                      child: Text(
                        productId != null ? "Edit".tr : "Add".tr,
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
