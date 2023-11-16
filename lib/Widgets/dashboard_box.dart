import 'package:clinic_app/shared/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget box(String text, String asset) {
  return Container(
    height: 240.h,
    width: 155.w,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
    margin: EdgeInsets.all(10.h),
    padding: EdgeInsets.all(10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: EdgeInsets.only(top: 5.h),
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: theme(sz: 18, wt: FontWeight.w600),
            )),
        SizedBox(height: 140.h, child: Image.asset(asset)),
      ],
    ),
  );
}
