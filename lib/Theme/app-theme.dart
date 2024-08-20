// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Theme/app-colors.dart';

class AppTheming {
  static ThemeData LightTheme = ThemeData(
      cardTheme: CardTheme(
        color: AppColor.whiteColor,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      appBarTheme: AppBarTheme(
        titleSpacing: 52,
        toolbarHeight: 100,
        backgroundColor: AppColor.PraimaryColor,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white),
      ),
      scaffoldBackgroundColor: AppColor.scafuldColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: false,
        showSelectedLabels: true,
        // type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.transColor,
        selectedItemColor: AppColor.PraimaryColor,
        unselectedItemColor: AppColor.iconColor,
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white)),
        backgroundColor: Color(0xff5D9CEC),
      ));

  ///////////////Darck Theme ///////////////////////////

  static ThemeData DarckTheme = ThemeData(
      appBarTheme: AppBarTheme(
        titleSpacing: 52,
        toolbarHeight: 100,
        backgroundColor: AppColor.PraimaryColor,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black),
      ),
      scaffoldBackgroundColor: AppColor.DarchPraimaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: false,
        showSelectedLabels: true,
        // type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.transColor,
        selectedItemColor: AppColor.PraimaryColor,
        unselectedItemColor: AppColor.iconColor,
      ),
      cardTheme: CardTheme(
        color: AppColor.DarchPraimaryColor,
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColor.buttonbarColor,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Color(0xff141922), width: 5)),
        backgroundColor: Color(0xff5D9CEC),
      ));
}
