import 'package:clinic_app/shared/colors.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget contain(
  String pName,
  String pPhone,
  String datetime,
  String reason,
  String? fee,
  String? staff,
  String status,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.all(15.w),
    padding: EdgeInsets.all(15.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20.w),
                  color: primaryColor),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 50.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Patient Name : ',
                        style: theme(sz: 10, clr: Colors.blueGrey),
                      ),
                      Text(
                        pName,
                        style: theme(sz: 10, clr: Colors.blueGrey),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.5.w),
                  Row(
                    children: [
                      Text(
                        'Patient Phone No. :',
                        style: theme(sz: 10, clr: Colors.blueGrey),
                      ),
                      Text(
                        pPhone,
                        style: theme(sz: 10, clr: Colors.blueGrey),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.5.w),
                  Row(
                    children: [
                      Text(
                        'Requested Date : ',
                        style: theme(sz: 10, clr: Colors.blueGrey),
                      ),
                      Text(
                        datetime,
                        style: theme(sz: 10, clr: Colors.blueGrey),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              'Status : ',
              style: theme(sz: 10, clr: Colors.black54),
            ),
            Text(
              status,
              style: theme(sz: 10, clr: Colors.black54),
            ),
          ],
        ),
        // SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              'Reason : ',
              style: theme(sz: 10, clr: Colors.black54),
            ),
            Text(
              reason,
              style: theme(sz: 10, clr: Colors.black54),
            ),
          ],
        ),
        fee != null
            ? Row(
                children: [
                  Text(
                    'Base Fee : ',
                    style: theme(sz: 10, clr: Colors.black54),
                  ),
                  Text(
                    fee,
                    style: theme(sz: 10, clr: Colors.black54),
                  ),
                ],
              )
            : const SizedBox(),
        staff != null
            ? Row(
                children: [
                  Text(
                    'Assigned Physiotherapist : ',
                    style: theme(sz: 10, clr: Colors.black54),
                  ),
                  Text(
                    staff,
                    style: theme(sz: 10, clr: Colors.black54),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    ),
  );
}
