// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/database.dart';
import '../shared/colors.dart';

void displayDialog(
  String fee,
  String appId,
  String staffUid,
  BuildContext context,
  String token,
    String physioName,
    String physioEmail,
) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    title: 'Assign Staff?',
    desc: 'Are you sure you want to assign this staff to the appointment',
    btnOkOnPress: () async {
      bool isSuccess =
          await Database().assignStaff(fee, appId, staffUid, context);
      if (isSuccess) {
        notificationSender(staffUid, token);
        sendEmail(physioName,physioEmail);
        AwesomeDialog(
                animType: AnimType.leftSlide,
                dialogType: DialogType.success,
                title: 'Staff Assigned',
                context: context)
            .show();

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }
    },
    btnCancelOnPress: () {
      Navigator.of(context).pop();
    },
    dismissOnBackKeyPress: false,
    dismissOnTouchOutside: true,
    animType: AnimType.leftSlide,
    btnOkColor: primaryColor,
    btnCancelColor: Colors.grey,
  ).show();
}

Future sendEmail(String physioName, String physioEmail) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = "service_v996fni";
  const templateId = "template_vudrmci";
  const userId = "uKQwGOIDB87MtK2bH";
  const privateKey = "ngRkdjVP0tQRe5Wf6iIM0";
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      "service_id": serviceId,
      "template_id": templateId,
      "user_id": userId,
      "accessToken": privateKey,
      "template_params": {
        "name": physioName,
        "subject": "------",
        "message": "-----",
        "user_email": physioEmail,
      }
    }),
  );
  if (kDebugMode) {
    print(response.body);
  }
}

void notificationSender(String staffUid, String patientToken) async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('StaffTokens')
      .doc(staffUid)
      .get();
  String token = (documentSnapshot.data()! as Map<String, dynamic>)['token'];
  if (kDebugMode) {
    print(token);
    print('...');
    print("patient token = ");
    print(patientToken);
  }
  sendPushMessage(
      patientToken, 'Appointment Assigned', 'Your appointment in assigned');
  sendPushMessage(
    token,
    'New Appointment',
    'You have a new appointment',
  );
}

void sendPushMessage(String token, String title, String body) async {
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
          'body': body,
          'title': title,
        },
        "notification": <String, dynamic>{
          "title": title,
          "body": body,
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
