import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  LightTheme._();

  static ThemeData light = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    drawerTheme: DrawerThemeData(
        elevation: 7.0,
        shape: Border.all(
            color: Colors.blueGrey.shade900,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside)),
    // scaffoldBackgroundColor: AppTheme.bgColor,
    appBarTheme: AppBarTheme(
      elevation: 1.5,
      centerTitle: true,
      // backgroundColor: Colors.blueGrey.shade700,
      systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: Colors.blueGrey[900],
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
      titleTextStyle: const TextStyle(color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blueGrey.shade50,
      iconColor: Colors.blueGrey.shade900,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.blueGrey.shade800,
            width: 1.9,
            strokeAlign: BorderSide.strokeAlignOutside),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserrat(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
        .copyWith(background: Colors.redAccent.shade200),
  );
}
