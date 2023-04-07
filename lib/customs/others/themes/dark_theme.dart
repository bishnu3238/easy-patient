import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme{
  DarkTheme._();
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
        color: Colors.black, titleTextStyle: TextStyle(color: Colors.white)),
    drawerTheme: DrawerThemeData(
        elevation: 7.0,
        shape: Border.all(
            color: Colors.blueGrey.shade900,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside)),
    listTileTheme: const ListTileThemeData(tileColor: Colors.black),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.grey,
      disabledBorder: InputBorder.none,
      filled: true,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      contentPadding: EdgeInsets.symmetric(
        vertical: 22,
        horizontal: 26,
      ),
    ),
    textTheme: TextTheme(
      displayMedium: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        color: Colors.redAccent.shade400,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.redAccent.shade200,
        fontSize: 24,
      ),
    ),
  );

}