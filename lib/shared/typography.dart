import 'package:clinic_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

//......................................................................................................................
TextStyle theme(
    {int? sz, Color? clr, double? sp, FontWeight? wt, FontStyle? st}) {
  int size = 25;
  Color color = primaryColor;
  double space = 0.5;
  FontWeight weight = FontWeight.bold;
  FontStyle style = FontStyle.normal;

  if (sz != null) {
    size = sz;
  }
  if (clr != null) {
    color = clr;
  }
  if (sp != null) {
    space = sp;
  }
  if (wt != null) {
    weight = wt;
  }
  if (st != null) {
    style = st;
  }

  return TextStyle(
          fontSize: size.w,
          color: color,
          letterSpacing: space,
          fontWeight: weight,
          fontStyle: style);
}

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.indigo, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.indigo, width: 2),
  ),
);
