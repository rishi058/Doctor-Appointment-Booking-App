import 'package:clinic_app/screens/patient/take_patient_feedback.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/colors.dart';

Widget appointmentHistory(
    String date,
    String time,
    String reason,
    String doctor,
    String fee,
    String status,
    bool isFeedbackGiven,
    String staffUid,
    String appointmentId,
    BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(5.w),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              date,
              style: theme(
                sz: 18,
                wt: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              time,
              style: theme(
                sz: 18,
                wt: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Reason : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),
            ),
            Text(
              reason,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Status : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),
            ),
            Text(
              status,
              style: theme(
                  sz: 14,
                  wt: FontWeight.w500,
                  clr: status == 'completed' ? Colors.deepPurple : Colors.red),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Physiotherapist Assigned : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),
            ),
            Text(
              doctor,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Fee : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.black),
            ),
            Text(
              fee,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.deepPurple),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        isFeedbackGiven == false
            ? Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TakeFeedbackPage(
                              id: staffUid,
                              appointmentId: appointmentId,
                            ),
                          ),
                        );
                      },
                      child: feedbackButton()),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const Divider(thickness: 1.4),
      ],
    ),
  );
}

Widget feedbackButton() {
  return Container(
    width: double.infinity,
    height: 25.h,
    decoration: BoxDecoration(
      border: Border.all(width: 1.5, color: buttonColor),
      borderRadius: BorderRadius.circular(7.w),
      // color: buttonColor,
    ),
    margin: EdgeInsets.symmetric(horizontal: 50.w),
    child: Align(
        alignment: Alignment.center,
        child: Text(
          'Give Feedback',
          style: theme(sz: 17, clr: buttonColor),
        )),
  );
}
