import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static LinearGradient loginGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xff032849),
      const Color(0xff032747).withOpacity(.96),
      const Color(0xff01080F).withOpacity(0),
    ],
  );

  static TextStyle boldStyle({required Color color, double? size}) {
    return GoogleFonts.montserrat(
        color: color, fontSize: size ?? 25, fontWeight: FontWeight.bold);
  }

  static TextStyle lightStyle({required Color color, double? size}) {
    return GoogleFonts.montserrat(
        color: color, fontSize: size ?? 15, fontWeight: FontWeight.w500);
  }
}
