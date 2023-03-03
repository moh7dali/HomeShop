import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/views/Screens/Users/product_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/views/Screens/Users/peronalPage/personalpage.dart';
import 'package:homeShop/views/Widgets/sectionscard.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final Home _Home = Home();
bool status8 = false;
int _page = 0;
Widget _showPage = new Home();
String username = "";
String img_url = "";

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        username = event['Fullname'];
        img_url = event['img'];
      });
    });
    return Scaffold(
      backgroundColor: backgroud,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(AssetsConstant.logo2, width: Get.width * .2),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return personalInfo(
                    user_id: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
              ));
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(img_url),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      drawer: Drawer(),
      body: Padding(
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
                    Text("Let's Make a\n Great Deal",
                        style: GoogleFonts.nunito(
                          fontSize: titleSize,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Get.to(ProductScreen());
                      },
                      CardTitle: "Food",
                      CardSubTitle: "Home Made Food",
                      ImageName: AssetsConstant.food,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.pushNamed(context, "cv");
                      },
                      CardTitle: "CV",
                      CardSubTitle: "Create your CV",
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
                        Navigator.pushNamed(context, "jobs");
                      },
                      CardTitle: "Jobs",
                      CardSubTitle: "Find your job easly",
                      ImageName: AssetsConstant.hoodie,
                      width: Get.width * .5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.pushNamed(context, "interview");
                      },
                      CardTitle: "Interview Questions",
                      CardSubTitle: "",
                      ImageName: AssetsConstant.gamer,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
          buttonSize: Size(70, 70),
          spaceBetweenChildren: 15,
          child: Icon(
            Ionicons.menu,
            size: 30,
          ),
          backgroundColor: buttonColor,
          children: [
            SpeedDialChild(
              child: Icon(Icons.logout),
              label: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signOut();
                Navigator.popAndPushNamed(context, "Login");
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return personalInfo(
                      user_id: FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                ));
              },
            ),
          ]),
    );
  }
}
