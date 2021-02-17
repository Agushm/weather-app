//* Device size
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Color primaryColor = Color(0xff1E2124);
Color bgColor = Color(0xff2E3238);
Color bgGreyColor = Color(0xffEDEDF5);
Color blueColor = Color(0xff1281CF);
Color redColor = Color(0xffCF2412);
Color purpleColor = Color(0xff656DF9);

TextStyle fontWhite = GoogleFonts.poppins(
  color: Colors.white,
);

TextStyle fontBlack = GoogleFonts.poppins(
  color: Colors.black,
);

TextStyle fontLogo = TextStyle(
  fontFamily: "GetShow",
);
