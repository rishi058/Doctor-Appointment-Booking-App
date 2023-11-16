import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

void notificationSender() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('Tokens')
      .doc('superVisorToken')
      .get();
  String token = (documentSnapshot.data()! as Map<String, dynamic>)['token'];
  if (kDebugMode) {
    print(token);
  }
  sendPushMessageSupervisor(token);
  DocumentSnapshot documentSnapshot1 = await FirebaseFirestore.instance
      .collection('Tokens')
      .doc('adminToken')
      .get();
  String token1 =
  (documentSnapshot1.data()! as Map<String, dynamic>)['token'];
  if (kDebugMode) {
    print(token);
  }
  sendPushMessageAdmin(token1);
}

void sendPushMessageSupervisor(String token) async {
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
          'body': 'Assign appointment to staff',
          'title': 'New Appointment',
        },
        "notification": <String, dynamic>{
          "title": 'New Appointment',
          "body": 'Assign appointment to staff',
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

void sendPushMessageAdmin(String token) async {
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
          'body': 'You have a new Appointment admin.',
          'title': 'New Appointment',
        },
        "notification": <String, dynamic>{
          "title": 'New Appointment',
          "body": 'Assign appointment to staff',
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


void pushNotificationAboutAssignedAppointment(String staffUid, String patientToken) async {
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