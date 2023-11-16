import 'package:clinic_app/shared/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget allAppointment(String date, String time, String reason, String? doctor, String fee, String patientName){
  return Container(
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(5.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(date, style: theme(sz: 18, wt: FontWeight.bold,),),
            SizedBox(width: 20.w,),
            Text(time,  style: theme(sz: 18, wt: FontWeight.bold,),),
          ],
        ),
        SizedBox(height: 5.h,),
        Row(
          children: [
            Text('Patient name : ', style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),),
            Text(patientName, style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple), overflow: TextOverflow.ellipsis,),
          ],
        ),
        SizedBox(height: 5.h,),
        doctor!=null?Column(
          children: [
            Row(
              children: [
                Text('Physiotherapist Assigned : ', style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),),
                Text(doctor, style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple), overflow: TextOverflow.ellipsis,),
              ],
            ),
            SizedBox(height: 5.h,),
          ],
        ):const SizedBox(),
        Row(
          children: [
            Text('Reason : ', style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),),
            Text(reason, style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple), overflow: TextOverflow.ellipsis,),
          ],
        ),
        SizedBox(height: 5.h,),
        Row(
          children: [
            Text('Fee : ', style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),),
            Text(fee, style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple), overflow: TextOverflow.ellipsis,),
          ],
        ),
        const Divider(thickness: 1.4),
      ],
    ),

  );
}