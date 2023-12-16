import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Colors.green;
const Color secondaryColor = Color(0XFFFF3333);
Color blkOpacity = Colors.black.withOpacity(0.5);
Color greyOpacity = Colors.grey.shade100;
// double height = MediaQuery.of(context).size.height;
OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderRadius: appCircleRaduis,
  borderSide: BorderSide(
    color: greyOpacity,
  ),
);

BorderRadius appCircleRaduis = BorderRadius.circular(20);

BoxShadow appBoxShadow = BoxShadow(
  blurRadius: 20,
  color: Colors.black.withOpacity(.1),
);

ThemeData themeData = ThemeData(
  primaryColor: primaryColor,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  scaffoldBackgroundColor: const Color(0XFFFFFFFF),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 60,
      color: primaryColor,
      fontWeight: FontWeight.w900,
    ),
    displayMedium: TextStyle(fontSize: 18),
    displaySmall: TextStyle(fontSize: 20),
    titleLarge: TextStyle(fontSize: 36),
    titleMedium: TextStyle(fontSize: 26),
    titleSmall: TextStyle(fontSize: 16),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(fontSize: 26),
  ),
);
