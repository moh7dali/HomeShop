// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/viewmodel/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashViewModel>(
        init: SplashViewModel(),
        builder: (controller) => Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                AssetsConstant.splashBack,
                fit: BoxFit.fill,
              ),
            ),
            AnimatedPositioned(
                top: controller.isAnimated ? Get.height * .1 : Get.height * .25,
                left: 0,
                right: 0,
                duration: const Duration(seconds: 2),
                child: Hero(
                    tag: 'logoTAg',
                    child: Image.asset(
                      AssetsConstant.logo,
                      height: Get.height * .3,
                    )))
          ],
        ),
      ),
    );
  }
}
