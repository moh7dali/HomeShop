import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/main.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/language_viewmodel.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageViewModel>(
      init: LanguageViewModel(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                  child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.updateLanguage('ar');
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                    color: containerBackgroun, width: 2)),
                            backgroundColor:
                                appLanguage == "ar" ? iconColor : Colors.white,
                            minimumSize:
                                Size(Get.width * .9, Get.height * .055)),
                        child: Text(
                          "العربية",
                          style:
                              AppTheme.boldStyle(color: Colors.black, size: 20),
                        ),
                      ),
                      SizedBox(height: Get.height * .07),
                      ElevatedButton(
                          onPressed: () {
                            controller.updateLanguage('en');
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                      color: containerBackgroun, width: 2)),
                              backgroundColor: appLanguage == "en"
                                  ? iconColor
                                  : Colors.white,
                              minimumSize:
                                  Size(Get.width * .9, Get.height * .055)),
                          child: Text(
                            "English",
                            style: AppTheme.boldStyle(
                                color: Colors.black, size: 20),
                          ))
                    ]),
              )),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: Get.height * .12,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text("Language".tr),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
