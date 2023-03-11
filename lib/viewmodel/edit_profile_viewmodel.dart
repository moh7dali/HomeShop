import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends GetxController {
  String? imgUrl;
  String userName = "";
  String userType = "";
  bool isLoad = true;

  TextEditingController fullnameconrller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController faceBookController = TextEditingController();
  TextEditingController instgramController = TextEditingController();
  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  Future getUserInfo() async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['user_id'] ==
            FirebaseAuth.instance.currentUser!.uid) {
          imgUrl = element.get('img');
          print("::::::::::::;");
          print(element.get('img'));
          userName = element.get('Fullname');
          fullnameconrller.text = element.get('Fullname');
          phoneController.text = element.get('phone');
          userType = element.get('rules');
          whatsAppController.text = element.get('whatsappUrl');
          faceBookController.text = element.get('facebookUrl');
          instgramController.text = element.get('instgramUrl');

          update();
        }
      });
    });
    isLoad = false;
    update();
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
}
