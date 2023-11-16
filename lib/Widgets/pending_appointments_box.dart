// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/services/database.dart';
import 'package:clinic_app/shared/colors.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:clinic_app/screens/supervisor/assign_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget pendingAppointments(
  String date,
  String time,
  String name,
  String phone,
  String address,
  String reason,
  String appointmentId,
  BuildContext context,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.w),
      color: Colors.white,
    ),
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(10.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
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
              'Patient Name : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              name,
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
              'Patient Contact No. : ',
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
              'Address : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              address,
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
              'Reason : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              reason,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AssignStaff(
                      appointmentId: appointmentId,
                    )));
          },
          child: assignButton(),
        ),
        GestureDetector(
          onTap: () {
            AwesomeDialog(
                    dialogType: DialogType.question,
                    title: 'Cancel/Reshedule',
                    desc:
                        'The appointment will be cancelled and the patient will be asked to reshedule it.',
                    animType: AnimType.leftSlide,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      bool isSuccess = await Database().cancelAppointment(
                        appointmentId,
                        context,
                      );
                      if (isSuccess) {
                        AwesomeDialog(
                                context: context,
                                dismissOnBackKeyPress: false,
                                dismissOnTouchOutside: false,
                                dialogType: DialogType.error,
                                title: 'Appointment Cancelled')
                            .show();
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    btnOkColor: primaryColor,
                    btnCancelColor: Colors.grey,
                    context: context)
                .show();
          },
          child: cancelReschedule(),
        ),
      ],
    ),
  );
}

Widget assignButton() {
  return Container(
    width: double.infinity,
    height: 25.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7.w),
      color: buttonColor,
    ),
    margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
    child: Align(
        alignment: Alignment.center,
        child: Text(
          'Assign a physiotherapist',
          style: theme(sz: 15, clr: Colors.white),
        )),
  );
}

Widget cancelReschedule() {
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
          'Cancel/Reschedule',
          style: theme(sz: 15, clr: buttonColor),
        )),
  );
}
