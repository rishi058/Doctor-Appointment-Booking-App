// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic/shared/colors.dart';
import 'package:clinic/shared/typography.dart';
import 'package:clinic/services/database.dart';
import 'package:clinic/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

String func(String date, String duration, String otp) {
  int days = int.parse(duration) - 1;
  DateTime temp = DateFormat('dd-MM-yyyy').parse(date);
  final deadline = Jiffy(temp).add(days: days).dateTime;
  if (DateTime.now().isBefore(deadline)) {
    return "xxxx";
  }
  return otp;
}

Widget appointments(
    String date,
    String time,
    String reason,
    String doctor,
    String fee,
    String status,
    String phone,
    BuildContext context,
    String appointmentId,
    String staffId,
    String Otp,
    String duration,
    ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.w),
      color: Colors.white,
    ),
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(10.w),
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
              'Status  :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            status == 'assigned'
                ? Text(
                    'Confirmed',
                    style: theme(
                      sz: 14,
                      wt: FontWeight.w500,
                      clr: Colors.blue,
                    ),
                  )
                : status == 'pending'
                    ? Text(
                        'Pending',
                        style: theme(
                          sz: 14,
                          wt: FontWeight.w500,
                          clr: Colors.redAccent,
                        ),
                      )
                    : Text(
                        'Completed',
                        style: theme(
                          sz: 14,
                          wt: FontWeight.w500,
                          clr: Colors.lightGreen,
                        ),
                      )
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Reason  :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              reason,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
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
              'Base Fee :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              fee,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
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
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              doctor,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
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
              'Physiotherapist No. : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              phone,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
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
              'Secret Otp : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
             func(date, duration, Otp),
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
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
              'Duration : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              "$duration day's",
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          onTap: () {
            if (status != "assigned") {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
                buttonsBorderRadius: const BorderRadius.all(
                  Radius.circular(2),
                ),
                dismissOnTouchOutside: true,
                dismissOnBackKeyPress: false,
                dialogBackgroundColor: bgColor,
                animType: AnimType.leftSlide,
                title: 'Cancel Appointment?',
                desc: 'Are You sure, you want to cancel this appointment?',
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  if (kDebugMode) {
                    print(appointmentId);
                  }
                  bool isSuccess = await Database()
                      .cancelAppointment(appointmentId, context);
                  if (isSuccess) {
                    Shared().snackbar(context, 'Appointment Cancelled');
                  }
                },
                btnCancelColor: Colors.grey,
                btnOkColor: primaryColor,
              ).show();
            }
          },
          child: cancelButton(status),
        ),
      ],
    ),
  );
}

Widget cancelButton(String status) {
  Color clr = buttonColor;
  if (status == 'assigned') {
    clr = Colors.blueGrey.withOpacity(0.6);
  }
  return Container(
    width: double.infinity,
    height: 25.h,
    decoration: BoxDecoration(
      border: Border.all(width: 1.5, color: clr),
      borderRadius: BorderRadius.circular(7.w),
      // color: buttonColor,
    ),
    margin: EdgeInsets.symmetric(horizontal: 50.w),
    child: Align(
        alignment: Alignment.center,
        child: Text(
          'Cancel',
          style: theme(sz: 17, clr: clr),
        )),
  );
}
