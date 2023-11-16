// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import '../services/email_js.dart';
import '../services/firebase_push_notification.dart';
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
        pushNotificationAboutAssignedAppointment(staffUid, token);
        sendEmailAboutAssignedTask(physioName,physioEmail);
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


