import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../import.dart';

TextStyle textStyle(double d) {
  return GoogleFonts.wellfleet(
      letterSpacing: 1.0,
      color: Colors.teal,
      fontWeight: FontWeight.w900,
      fontSize: media.phoneWidth * d);
}
