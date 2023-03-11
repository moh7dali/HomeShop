import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/viewmodel/edit_profile_viewmodel.dart';
import 'package:homeShop/viewmodel/profile_viewmodel.dart';
import 'package:homeShop/views/Screens/peronalPage/personalpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:homeShop/utils/constants.dart';

class editProfile extends StatelessWidget {
  editProfile();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileViewModel>(
      init: EditProfileViewModel(),
      builder: (controller) => Scaffold(
        backgroundColor: backgroud,
        appBar: AppBar(
          backgroundColor: backgroud,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: controller.isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: ListView(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * .3,
                        child: controller.pickedimg == null
                            ? controller.imgUrl != null
                                ? Image.asset(AssetsConstant.logo)
                                : Image.network(controller.imgUrl!)
                            : Image.file(
                                controller.pickedimg!,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text("Choose image From ?",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    controller.funimg(ImageSource.gallery),
                                icon: const Icon(Ionicons.folder),
                              ),
                              IconButton(
                                onPressed: () =>
                                    controller.funimg(ImageSource.camera),
                                icon: const Icon(
                                  Ionicons.camera,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: 'Full name',
                            hintText: 'edit your name',
                            border: OutlineInputBorder()),
                        controller: controller.fullnameconrller,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'phone',
                            hintText: 'Enter your phone num',
                            border: OutlineInputBorder()),
                        controller: controller.phoneController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Ionicons.logo_whatsapp),
                            labelText: 'whatsApp',
                            hintText: 'Enter your whatsApp url',
                            border: OutlineInputBorder()),
                        controller: controller.whatsAppController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Ionicons.logo_facebook),
                            labelText: 'FaceBook',
                            hintText: 'Enter your FaceBook account',
                            border: OutlineInputBorder()),
                        controller: controller.faceBookController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Ionicons.logo_instagram),
                            labelText: 'Instgram',
                            hintText: 'Enter your Instgram account',
                            border: OutlineInputBorder()),
                        controller: controller.instgramController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(),
                            padding: EdgeInsets.symmetric(vertical: 15)),
                        onPressed: () async {
                          final url;
                          if (controller.pickedimg == null) {
                            url = controller.imgUrl;
                          } else {
                            DateTime now = DateTime.now();
                            final storageRef = FirebaseStorage.instance
                                .ref()
                                .child('Users_img')
                                .child(
                                    '${controller.userName}${now.hour}${now.minute}${now.second}.jpg');
                            await storageRef.putFile(controller.pickedimg!);
                            url = await storageRef.getDownloadURL();
                          }

                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'img': url,
                            'Fullname': controller.fullnameconrller.text,
                            'phone': controller.phoneController.text,
                            'whatsappUrl': controller.whatsAppController.text,
                            'instgramUrl': controller.instgramController.text,
                            'facebookUrl': controller.faceBookController.text,
                          });

                          ProfileViewModel profileViewModel =
                              Get.find<ProfileViewModel>();
                          await profileViewModel.getUserData();

                          Get.back();
                        },
                        child: Text(
                          "Update",
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
      ),
    );
  }
}
