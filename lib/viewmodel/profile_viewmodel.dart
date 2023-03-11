// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  String imgUrl = "";
  String email = "";
  String username = "";
  String phone = "";
  String userType = "";
  bool visibilty = false;
  bool isLoad = true;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future getUserData() async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['user_id'] ==
            FirebaseAuth.instance.currentUser!.uid) {
          imgUrl = element.get('img');
          email = element.get('Email');
          username = element.get('Fullname');
          phone = element.get('phone');
          userType = element.get('rules');
          visibilty = true;
          update();
        }
      });
    });
    isLoad = false;
    update();
  }
}
