// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic/services/database.dart';
import 'package:clinic/shared/shared.dart';
import 'package:clinic/shared/typography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../shared/colors.dart';

Widget currentAppointments(
  String date,
  String time,
  String name,
  String phone,
  String address,
  String reason,
  String fee,
  String? staff,
  String userType,
  BuildContext context,
  String appointmentUid,
  String secretOtp,
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
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Base Fee : ',
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
        staff != null
            ? Row(
                children: [
                  Text(
                    'Appointed Staff : ',
                    style: theme(
                        sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
                  ),
                  Text(
                    staff,
                    style: theme(
                        sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Durations : ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              "$duration day's",
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        userType == "staff"
            ? Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        popUpDialog(appointmentUid, context, secretOtp);
                      },
                      child: completeButton()),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        userType != "staff"
            ? Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  InkWell(
                      onTap: () {
                        editDurationWidget(appointmentUid, context, duration);
                      },
                      child: editButton()),
                ],
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}

Widget editButton() {
  return Container(
    width: double.infinity,
    height: 25.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7.w),
      color: buttonColor,
    ),
    margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 50.w),
    child: Align(
        alignment: Alignment.center,
        child: Text(
          'Edit Duration',
          style: theme(sz: 15, clr: Colors.white),
        )),
  );
}

Widget completeButton() {
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
          'Mark As Complete',
          style: theme(sz: 17, clr: buttonColor),
        )),
  );
}

editDurationWidget(
    String appointmentUid, BuildContext context, String days) async {
  TextEditingController durtaionController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            title: const Text(
              "Enter the duration for this Appointment",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: durtaionController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                        labelText: "days",
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: Container(
                          height: 37.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: buttonColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: buttonColor, fontSize: 17.sp),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    GestureDetector(
                      child: Container(
                        height: 37.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                            child: Text(
                          'Submit',
                          style:
                              TextStyle(color: Colors.white, fontSize: 17.sp),
                        )),
                      ),
                      onTap: () async {
                        // complete this function
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'supervisor-dashboard', (route) => false);
                        await Database()
                            .updateDuration(
                          durtaionController.text.trim(),
                          appointmentUid,
                          context,
                        )
                            .then((value) {
                          if (value) {
                            Shared().snackbar(
                                context, 'Duration Updated Successfully');
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
      });
}

popUpDialog(
    String appointmentUid, BuildContext context, String secretOtp) async {
  String amount = "";
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            title: const Text(
              "Enter the Secret Otp Given by Patient",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        amount = val;
                      });
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                        labelText: "Secret Otp",
                        prefixIcon: Icon(
                          Icons.password,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: Container(
                          height: 37.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: buttonColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: buttonColor, fontSize: 17.sp),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    GestureDetector(
                      child: Container(
                        height: 37.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                            child: Text(
                          'Submit',
                          style:
                              TextStyle(color: Colors.white, fontSize: 17.sp),
                        )),
                      ),
                      onTap: () async {
                        if (amount == secretOtp) {
                          bool isSuccess = await Database()
                              .completeAppointment(appointmentUid, context);
                          if (isSuccess) {
                            notificationSender(appointmentUid);
                            notificationSender(appointmentUid);
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              dialogType: DialogType.success,
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              dialogBackgroundColor: bgColor,
                              title: 'Appointment Completed Successfully',
                            ).show();
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          } else {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              dialogType: DialogType.error,
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              dialogBackgroundColor: bgColor,
                              title: 'Appointment Completion failed',
                            ).show();
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          }
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Shared()
                              .snackbar(context, 'Please enter correct otp');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
      });
}

void notificationSender(String appointmentId) async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('appointments')
      .doc(appointmentId)
      .get();
  String patientUid =
      (documentSnapshot.data()! as Map<String, dynamic>)['patientUid'];
  DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection('PatientTokens')
      .doc(patientUid)
      .get();
  String token = (snap.data()! as Map<String, dynamic>)['token'];
  if (kDebugMode) {
    print('Patient uid is');
    print(token);
  }
  sendPushMessage(token);
}

void sendPushMessage(String token) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAwCZk4RU:APA91bGRH22befoUBp5W3laVm11ZhYumSp0On6NfQw-T_jYcgNThCOr_1ofGwYf3jX7s0L1GgHkToHMASHZ1_yqNFmwPZUonS74xmcIMkHqVjOSc1z0KcxMSzSHfZjjXCQghxJMeZFPu'
      },
      body: jsonEncode(<String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': 'Your Appointment is Completed',
          'title': 'Appointment Completed',
        },
        "notification": <String, dynamic>{
          "title": 'Appointment Completed',
          "body": 'Your Appointment is Completed',
          "android_channel_id": "dbfood"
        },
        "to": token,
      }),
    );
  } catch (e) {
    if (kDebugMode) {
      print("error push notification");
    }
  }
}
