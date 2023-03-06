import 'package:flutter/material.dart';
import 'package:homeShop/utils/constants.dart';

class SectionsCard extends StatelessWidget {
  SectionsCard({
    this.CardTitle,
    this.CardSubTitle,
    this.ImageName,
    this.width,
    required this.OnTapping,
  });
  String? CardTitle;
  String? CardSubTitle;
  Function() OnTapping;
  String? ImageName;
  double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTapping,
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 260,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "${ImageName}",
                width: width,
              ),
              ListTile(
                title: Text(
                  "${CardTitle}",
                  style: const TextStyle(
                    fontSize: subTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "${CardSubTitle}",
                    style: TextStyle(
                      fontSize: ParagraphSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
