import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';

class NoItemWidget extends StatelessWidget {
  NoItemWidget({this.imgUrl, this.title, this.subTitle, this.imgSize});
  String? imgUrl;
  double? imgSize;
  String? title;
  String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerBackgroun.withOpacity(.4),
              border: Border.all(width: 2, color: iconColor)),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Image.asset(
              '$imgUrl',
              width: imgSize,
            ),
          ),
        ),
        SizedBox(height: Get.height * .02),
        Text(
          "$title".tr,
          style: AppTheme.boldStyle(color: Colors.black, size: 20),
        ),
        SizedBox(height: Get.height * .02),
        Text("$subTitle".tr,
            textAlign: TextAlign.center,
            style: AppTheme.lightStyle(
              color: Colors.black,
            ))
      ]),
    );
  }
}
