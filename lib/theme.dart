import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static  Color primaryDark = HexColor("#171a25");
  static  Color primaryLight = HexColor("#f9f9fa");
  static  Color accentPrimary = HexColor("#43f98d");
  static  Color secondaryGray = HexColor("#31343f");

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryDark,
      scaffoldBackgroundColor: primaryDark,
      hintColor: accentPrimary,
      secondaryHeaderColor: secondaryGray,
      fontFamily: 'Montserrat', // Set default font family for all text
      textTheme:  TextTheme(
        displayLarge: TextStyle(
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
          height: 55 / 45, // Line height relative to font size
          color: primaryLight,
        ),
        displayMedium: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
          height: 50 / 40,
          color: primaryLight,
        ),
        displaySmall: TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
          height: 45 / 35,
          color: primaryLight,
        ),
        headlineMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          height: 40 / 30,
          color: primaryLight,
        ),
        headlineSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w900,
          height: 35 / 25,
          color: primaryLight,
        ),
        titleLarge: TextStyle(
          fontSize: 40.0,
           fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
          height: 30 / 20,
          color: primaryLight,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: primaryLight,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: primaryLight,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: primaryLight,
        ),
        labelLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: primaryLight,
        ),
        // Add other text styles if needed
      ),
      // Optionally, add other ThemeData customizations here
    );
  }
}
