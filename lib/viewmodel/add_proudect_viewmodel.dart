// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/viewmodel/home_company_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:homeShop/utils/helper.dart';
import 'package:homeShop/views/Screens/Company/mainCompany.dart';

class AddProductViewModel extends GetxController {
  AddProductViewModel({
    this.productId,
  });
  String? productId;
  TextEditingController englisNameController = TextEditingController();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Map<String, dynamic> data = {};
  bool isLoad = true;
  String? shopName;
  List<String> productCategory = [
    'food',
    'Clothes',
    'homeAccessories',
    'electronicAccessories'
  ];
  String? selectedProductCategory;
  bool isEdit = false;
  @override
  void onInit() {
    if (productId == null) {
      getUserinfo();
      print("no id");
    } else {
      getUserinfo();
      getProudectDetails(productId!);
      print("id is ${productId}");
    }
    super.onInit();
  }

  @override
  void onClose() {
    data = {};
    isLoad = true;
    englisNameController.clear();
    arabicNameController.clear();
    priceController.clear();
    pickedimg = null;
    selectedProductCategory = null;
    super.onClose();
  }

  final ImagePicker _picker = ImagePicker();
  File? pickedimg;

  funimg(ImageSource src) async {
    final XFile? image = await _picker.pickImage(source: src);
    if (image == null) {
      return;
    }
    pickedimg = File(image.path);
    update();
  }

  Future getUserinfo() async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['user_id'] ==
            FirebaseAuth.instance.currentUser!.uid) {
          shopName = element.data()['Fullname'];
          update();
        }
      });
    });
    isLoad = false;
    update();
  }

  String? imgUrl;
  Future getProudectDetails(String productId) async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("products").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["productID"] == productId) {
          data.addAll(element.data());
          print("_____________________");
          print(data);
          print("_____________________");
        }
        update();
      });
    });

    imgUrl = data['productImgUrl'];
    englisNameController.text = data['productName'];
    arabicNameController.text = data['productNameAr'];
    priceController.text = data['productPrice'].toString();
    selectedProductCategory = data['productCategory'];
    isEdit = true;
    update();
  }

  getProductCategory(String? val) {
    selectedProductCategory = val;
  }

  String? docID;
  Future addProduct({String? productId}) async {
    if (!isEdit) {
      var uuid = Uuid();
      if (selectedProductCategory != null && pickedimg != null) {
        DateTime now = DateTime.now();
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('products_img')
            .child('${shopName!}${now.hour}${now.minute}${now.second}.jpg');
        await storageRef.putFile(pickedimg!);
        final url = await storageRef.getDownloadURL();
        String date = DateFormat('yyyy-MM-ddTHH:mm:ss a').format(now);
        FirebaseFirestore.instance.collection('products').doc(uuid.v1()).set({
          "productAvailability": true,
          "productCategory": selectedProductCategory,
          "productID": uuid.v1(),
          "productImgUrl": url,
          "productName": englisNameController.text,
          "productNameAr": arabicNameController.text,
          "productPrice": int.parse(priceController.text.trim()),
          "shopID": FirebaseAuth.instance.currentUser!.uid,
          "shopName": shopName,
          'date': date,
        });
        if (Get.isRegistered<HomeCompanyViewModel>()) {
          HomeCompanyViewModel homeCompanyViewModel =
              Get.find<HomeCompanyViewModel>();
          await homeCompanyViewModel.init();
        }
        Get.back();
        onClose();
        update();
      } else
        Helper().errorSnackBar("Select Proudect Categorie or Image");
    } else {
      DateTime now = DateTime.now();
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('products_img')
          .child('${shopName!}${now.hour}${now.minute}${now.second}.jpg');
      final url;
      if (pickedimg != null) {
        await storageRef.putFile(pickedimg!);
        url = await storageRef.getDownloadURL();
      } else {
        url = imgUrl;
      }
      String date = DateFormat('yyyy-MM-ddTHH:mm:ss a').format(now);
      final db = FirebaseFirestore.instance;
      final docRef = await db.collection("products").get().then(
        (value) {
          docID = value.docs
              .firstWhere((element) => element.get("productID") == productId)
              .id;
        },
      );
      await FirebaseFirestore.instance
          .collection('products')
          .doc(docID)
          .update({
        "productAvailability": true,
        "productCategory": selectedProductCategory,
        "productImgUrl": url,
        "productName": englisNameController.text,
        "productNameAr": arabicNameController.text,
        "productPrice": int.parse(priceController.text.trim()),
        "shopID": FirebaseAuth.instance.currentUser!.uid,
        "shopName": shopName,
        'date': date,
      });
      if (Get.isRegistered<HomeCompanyViewModel>()) {
        HomeCompanyViewModel homeCompanyViewModel =
            Get.find<HomeCompanyViewModel>();
        await homeCompanyViewModel.init();
      }
      Get.back();
      Get.back();
      onClose();
      update();
    }
  }
}
