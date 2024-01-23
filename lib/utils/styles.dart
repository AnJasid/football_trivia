import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

//TextStyle
class TextAppearance {
  static final bebasNeueMedium = TextStyle(
    fontFamily: GoogleFonts.bebasNeue().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final bebasNeueSmall = TextStyle(
    fontFamily: GoogleFonts.bebasNeue().fontFamily,
    fontSize: 12,
    color: Colors.white,
  );
}
