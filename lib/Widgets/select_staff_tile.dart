import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../shared/typography.dart';

Widget staffTile(String name, String no, String address, String picUrl) {
  if(picUrl.isEmpty){
    picUrl = 'https://www.pngitem.com/pimgs/m/24-248631_blue-profile-logo-png-transparent-png.png';
  }
  return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(picUrl),
                ),
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12.w)),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      name,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Phone No. : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      no,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Address : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      address,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
}
