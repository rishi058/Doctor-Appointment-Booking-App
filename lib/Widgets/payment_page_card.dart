import 'package:clinic_app/shared/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget idCard(String name, String phone, String rating, String url) {
  if(url.isEmpty){
    url = 'https://www.pngitem.com/pimgs/m/24-248631_blue-profile-logo-png-transparent-png.png';
  }
  return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15.w),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12.w),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fill
                )
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 240.w,
            height: 80.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme(sz: 18, clr: Colors.black),
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Phone no. : ',
                      style: theme(sz: 14, clr: Colors.blueGrey),
                    ),
                    Text(
                      phone,
                      style: theme(sz: 14, clr: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Rating : ',
                      style: theme(sz: 14, clr: Colors.blueGrey),
                    ),
                    Text(
                      '$rating/5',
                      style: theme(sz: 14, clr: Colors.blueGrey),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ));
}
