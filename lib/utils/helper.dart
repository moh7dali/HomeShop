import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
  errorSnackBar(String message,
      {Icon? icon, bool isPend = false, bool isTop = false}) {
    Get.snackbar(
      "",
      message,
      padding: isPend ? EdgeInsets.all(30) : null,
      duration: isPend ? Duration(minutes: 1) : Duration(seconds: 2),
      titleText: Container(
        height: 0,
      ),
      borderColor: Colors.red,
      borderWidth: 1,
      borderRadius: 20,
      backgroundColor: Colors.white,
      mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('done'.tr)),
      icon: icon ??
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }
}
