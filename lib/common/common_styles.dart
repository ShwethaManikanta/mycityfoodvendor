import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyles {
  static bottomNavigationBarText() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      backgroundColor: Colors.transparent,
      fontSize: 10,
      fontWeight: FontWeight.w300,
    ));
  }

  static errorTextStyleStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 13,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static whiteText12BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText15BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static errorRed10TestStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 10,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w300,
    ));
  }

  static error8TextStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 8,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w300,
    ));
  }

  static textBarTextWhite() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            backgroundColor: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.white));
  }

  static textBarTextWhiteSize16() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 251, 124, 4)));
  }

  static textBarTextWhiteProductPriceSize14() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green));
  }

  static whiteText13BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600));
  }

  static textBarTextWhiteProductPrice() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            backgroundColor: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.white));
  }

  static customColorFontForButtomBar(Color color) {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      backgroundColor: Colors.transparent,
      fontSize: 10,
      color: color,
      fontWeight: FontWeight.w500,
    ));
  }

  static red12() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.red));
  }

  static textHeaderBlack16() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[800],
      backgroundColor: Colors.transparent,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ));
  }

  static textHeaderBlack14() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[800],
      backgroundColor: Colors.transparent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ));
  }

  static textDataBlack13() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[800],
      backgroundColor: Colors.transparent,
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ));
  }

  static textDataBlack12() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ));
  }

  static textDataBlack15() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[800],
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ));
  }

  static textDataWhite15() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ));
  }

  static textDataWhite12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 12,
      fontWeight: FontWeight.w900,
    ));
  }

  static textDataWhite20() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ));
  }

  static textDataWhite18() {
    return GoogleFonts.mulish(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 22,
      shadows: [
        Shadow(color: Colors.black54, offset: Offset(0, 1), blurRadius: 3)
      ],
      fontWeight: FontWeight.w600,
    ));
  }

  static textDataWhite13() {
    return GoogleFonts.mulish(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 13,
      shadows: [
        Shadow(color: Colors.brown, offset: Offset(0, 1), blurRadius: 1)
      ],
      fontWeight: FontWeight.w600,
    ));
  }

  static indexText() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Color(0xFF801E48),
      backgroundColor: Colors.transparent,
      fontSize: 16,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w700,
    ));
  }

  static headerTextWhite22() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 22,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w500,
    ));
  }

  static headerBlue() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.blue[800],
      backgroundColor: Colors.transparent,
      fontSize: 24,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }

  static textw400Blue() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.blue[800],
      backgroundColor: Colors.transparent,
      fontSize: 24,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w400,
    ));
  }

  static textw200BlueS14() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.blue[800],
      backgroundColor: Colors.transparent,
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w200,
    ));
  }

  static textw400Pink() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 233, 10, 54),
      backgroundColor: Color.fromARGB(0, 10, 1, 59),
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w400,
    ));
  }

  static textw400Amber() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 246, 52, 3),
      backgroundColor: Color.fromARGB(0, 10, 1, 59),
      fontSize: 22,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w400,
    ));
  }

  static textw200Amber() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 246, 52, 3),
      backgroundColor: Color.fromARGB(0, 10, 1, 59),
      fontSize: 24,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w200,
    ));
  }

  static textfontsize14Amber() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 246, 52, 3),
      backgroundColor: Color.fromARGB(0, 10, 1, 59),
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w400,
    ));
  }
}
