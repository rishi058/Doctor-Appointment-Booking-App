// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:clinic_app/models/feedback_model.dart';
import 'package:clinic_app/models/staff_model.dart';
import 'package:clinic_app/shared/colors.dart';
import 'package:clinic_app/models/appointment_model.dart';
import 'package:clinic_app/models/patient_model.dart';
import 'package:clinic_app/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../shared/drawer.dart';
import '../shared/user_type.dart';

class Database {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('PatientPhoneNumbers');

  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');

  CollectionReference staffs = FirebaseFirestore.instance.collection('staff');

  // storing user data to cloud firestore
  void storeUser(String phoneNumber, String uid) async {
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc('dIxT42QIFPSTtVcmmfAu').get();
    final data = documentSnapshot.data()! as Map<String, dynamic>;
    List allPhone = data['phoneNumbers'];
    if (!(allPhone.contains(phoneNumber))) {
      allPhone.add(phoneNumber);
      collectionReference.doc('dIxT42QIFPSTtVcmmfAu').set({
        'phoneNumbers': allPhone,
      });

      PatientModel patientModel = PatientModel(
          patientName: 'Anonymous',
          patientUid: uid,
          patientPhone: phoneNumber,
          patientProfilePic: '',
          patientAddress: '',
          patientAge: '');

      await FirebaseFirestore.instance.collection('patients').doc(uid).set(
            patientModel.toMap(),
          );
    }
  }

  Future<PatientModel?> getUser(String uid) async {
    try {
      DocumentSnapshot snap = await patients.doc(uid).get();
      PatientModel temp = PatientModel.fromSnap(snap);
      return temp;
    } catch (e) {
      return null;
    }
  }

  Future<StaffModel?> getStaff(String uid) async {
    try {
      DocumentSnapshot snap = await staffs.doc(uid).get();
      StaffModel temp = StaffModel.fromSnap(snap);
      return temp;
    } catch (e) {
      return null;
    }
  }


  Future<bool> updatePatientProfile(String uid, String picUrl, String name,
      String number, String address, String age, BuildContext ctx) async {
    try {
      await patients.doc(uid).update({
        "patientProfilePic": picUrl,
        "patientName": name,
        "patientPhone": number,
        "patientAddress": address,
        "patientAge": age,
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: buttonColor.withOpacity(0.6),
          content: const Text(' Changes Saved .. '),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(' Error Occurred . Try again ! '),
        ),
      );
      return false;
    }
  }

  Future<bool> updateStaff(String uid, String picUrl, String name,
      String number, String address, BuildContext ctx) async {
    try {
      await staffs.doc(uid).update({
        "staffProfPic": picUrl,
        "staffName": name,
        "staffPhone": number,
        "staffAddress": address,
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: buttonColor.withOpacity(0.6),
          content: const Text(' Changes Saved .. '),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(' Error Occurred . Try again ! '),
        ),
      );
      return false;
    }
  }

  // adding appointments in database as requested by user
  Future<bool> bookAppointMent(
    String patientName,
    String patientPhone,
    String patientAddress,
    String reason,
    String dateOfAppointment,
    String timeOfAppointment,
    BuildContext context,
  ) async {
    bool isSuccess = false;
    String patientUid = FirebaseAuth.instance.currentUser!.uid;
    try {
      String appointmentId = const Uuid().v1();
      String secretOtp = (Random().nextInt(900000) + 100000).toString();
      AppointmentModel appointmentModel = AppointmentModel(
        appointmentId: appointmentId,
        dateOfAppointment: dateOfAppointment,
        timeOfAppointment: timeOfAppointment,
        patientUid: patientUid,
        patientName: patientName,
        patientPhone: patientPhone,
        reason: reason,
        patientAddress: patientAddress,
        status: 'pending',
        paymentStatus: 'pending',
        secretOtp: secretOtp,
        duration: "1",
      );
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .set(appointmentModel.toMap());
      isSuccess = true;
      return isSuccess;
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Could Not Process.\nTry again later.',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return isSuccess;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Some Error Occurred.\nTry again later.',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return isSuccess;
    }
  }

  // retrieving appointment data from databse
  Stream<List<AppointmentModel>> get allAppointments {
    return FirebaseFirestore.instance
        .collection('appointments')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => AppointmentModel(
                appointmentId: (documentSnapshot.data()!
                    as Map<String, dynamic>)['appointmentId'],
                dateOfAppointment: (documentSnapshot.data()!
                    as Map<String, dynamic>)['dateOfAppointment'],
                patientAddress: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientAddress'],
                patientName: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientName'],
                patientPhone: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientPhone'],
                patientUid: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientUid'],
                paymentStatus: (documentSnapshot.data()!
                    as Map<String, dynamic>)['paymentStatus'],
                reason: (documentSnapshot.data()!
                    as Map<String, dynamic>)['reason'],
                status: (documentSnapshot.data()!
                    as Map<String, dynamic>)['status'],
                timeOfAppointment: (documentSnapshot.data()!
                    as Map<String, dynamic>)['timeOfAppointment'],
                assignedStaffName: (documentSnapshot.data()!
                        as Map<String, dynamic>)['assignedStaffName'] ??
                    "",
                assignedStaffPhone: (documentSnapshot.data()!
                        as Map<String, dynamic>)['assignedStaffPhone'] ??
                    "",
                assignedStaffUid: (documentSnapshot.data()!
                        as Map<String, dynamic>)['assignedStaffUid'] ??
                    "",
                baseFee: (documentSnapshot.data()!
                        as Map<String, dynamic>)['baseFee'] ??
                    "",
                secretOtp: (documentSnapshot.data()!
                        as Map<String, dynamic>)['secretOtp'] ??
                    "",
                isFeedBackGiven: (documentSnapshot.data()!
                    as Map<String, dynamic>)['isFeedBackGiven'] as bool,
                duration: (documentSnapshot.data()!
                        as Map<String, dynamic>)['duration'] ??
                    "1",
              ),
            )
            .toList());
  }

  // retrieving feedback model
  Stream<List<FeedBackModel>> get feedback {
    return FirebaseFirestore.instance
        .collection('feedbacks')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => FeedBackModel(
                feedBackId: (documentSnapshot.data()!
                    as Map<String, dynamic>)['feedBackId'],
                patientUid: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientUid'],
                patientName: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientName'],
                patientPhone: (documentSnapshot.data()!
                    as Map<String, dynamic>)['patientPhone'],
                staffUid: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffUid'],
                staffName: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffName'],
                staffPhone: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffPhone'],
                feedBack: (documentSnapshot.data()!
                    as Map<String, dynamic>)['feedBack'],
                dateOfFeedback: (documentSnapshot.data()!
                    as Map<String, dynamic>)['dateOfFeedback'],
                feedbackAppointmentId: (documentSnapshot.data()!
                    as Map<String, dynamic>)['feedbackAppointmentId'],
              ),
            )
            .toList());
  }

  // cancel appointment
  Future<bool> cancelAppointment(
      String appointmentId, BuildContext context) async {
    bool isSuccess = false;
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({
        'status': 'cancelled',
        'isFeedBackGiven': true,
      });
      isSuccess = true;
      return isSuccess;
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Could Not Process.\nTry again later.',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return isSuccess;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Some Error Occurred.\nTry again later.',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return isSuccess;
    }
  }

  // retrieving patient list
  Stream<List<PatientModel>> get allPatients {
    return FirebaseFirestore.instance
        .collection('patients')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => PatientModel(
                  patientName: (documentSnapshot.data()!
                      as Map<String, dynamic>)['patientName'],
                  patientUid: (documentSnapshot.data()!
                      as Map<String, dynamic>)['patientUid'],
                  patientPhone: (documentSnapshot.data()!
                      as Map<String, dynamic>)['patientPhone'],
                  patientProfilePic: (documentSnapshot.data()!
                      as Map<String, dynamic>)['patientProfilePic'],
                  patientAddress: (documentSnapshot.data()!
                      as Map<String, dynamic>)['patientAddress'],
                  patientAge: (documentSnapshot.data()!
                      as Map<String, dynamic>)['patientAge'],
                ))
            .toList());
  }

  // add staff to database
  Future<bool> addStaff(String name, String email, String password,
      String phone, BuildContext context) async {
    FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'SecondaryApp', options: Firebase.app().options);
    bool isSuccess = false;
    try {
      UserCredential credential =
          await FirebaseAuth.instanceFor(app: secondaryApp)
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      StaffModel staffModel = StaffModel(
          staffName: name,
          staffUid: credential.user!.uid,
          staffProfPic: '',
          staffPhone: phone,
          staffAddress: '',
          email: email,
          password: password);

      // add staff to databse
      await FirebaseFirestore.instance
          .collection('staff')
          .doc(credential.user!.uid)
          .set(staffModel.toMap());
      isSuccess = true;
      return isSuccess;
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.code);
      }
      if (error.code == 'email-already-in-use') {
        Shared().snackbar(context, 'Email already in use');
      } else if (error.code == 'invalid-email') {
        Shared().snackbar(context, 'Email Invalid');
      } else if (error.code == 'weak-password') {
        Shared().snackbar(context, 'Password too weak');
      }
      Shared().snackbar(context, 'Some error Occured!');
      return isSuccess;
    } catch (e) {
      Shared().snackbar(context, 'Some error Occured');
      return isSuccess;
    }
  }

  // retrieving staff list
  Stream<List<StaffModel>> get allStaff {
    return FirebaseFirestore.instance
        .collection('staff')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => StaffModel(
                staffName: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffName'],
                staffUid: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffUid'],
                staffProfPic: (documentSnapshot.data()!
                        as Map<String, dynamic>)['staffProfPic'] ??
                    "",
                staffPhone: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffPhone'],
                staffAddress: (documentSnapshot.data()!
                        as Map<String, dynamic>)['staffAddress'] ??
                    "",
                email:
                    (documentSnapshot.data()! as Map<String, dynamic>)['email'],
                password: (documentSnapshot.data()!
                    as Map<String, dynamic>)['password'],
                staffRating: (documentSnapshot.data()!
                    as Map<String, dynamic>)['staffRating'],
              ),
            )
            .toList());
  }

  // delete staff
  Future<bool> deleteStaff(String uid, BuildContext context) async {
    bool isSuccess = false;
    try {
      List<AppointmentModel> allAppointments = [];
      allAppointments = Provider.of<List<AppointmentModel>>(context, listen: false)
          .where((element) =>  element.status != 'completed' && element.assignedStaffUid==uid)
          .toList();

      for(int i=0; i<allAppointments.length; i++){
        String tempUid = allAppointments[i].appointmentId;
        try {
          await FirebaseFirestore.instance
              .collection('appointments')
              .doc(tempUid)
              .update({
            'status': 'cancelled',
            'isFeedBackGiven': true,
          });
        }
        catch(e){rethrow;}
        Timer(const Duration(milliseconds: 500), () {});
      }
      await FirebaseFirestore.instance.collection('staff').doc(uid).delete();
      isSuccess = true;
      return isSuccess;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Shared().snackbar(context, 'Some error Occured');
      return isSuccess;
    }
  }

  // assign staff to the appointment
  Future<bool> assignStaff(String fee, String appointmentId, String staffId,
      BuildContext context) async {
    bool isSuccess = false;
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('staff');
      DocumentSnapshot snapshot = await collectionReference.doc(staffId).get();
      final staff = snapshot.data()! as Map<String, dynamic>;

      FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({
        'assignedStaffName': staff['staffName'],
        'assignedStaffEmail': staff['email'],
        'assignedStaffPhone': staff['staffPhone'],
        'assignedStaffUid': staffId,
        'baseFee': fee,
        'status': 'assigned',
      });
      isSuccess = true;
      return isSuccess;
    } catch (e) {
      Shared().snackbar(context, 'Some Error Occurred');
      return isSuccess;
    }
  }

  Future<bool> completeAppointment(
      String appointmentId, BuildContext context) async {
    bool isSuccess = false;
    try {
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({
        'status': 'completed',
      });
      isSuccess = true;
      return isSuccess;
    } catch (e) {
      Shared().snackbar(context, 'Some Error Occurred');
      return isSuccess;
    }
  }

  Future<bool> addFeedBack(
    String staffUid,
    String staffName,
    String staffPhone,
    String patientName,
    String patientPhone,
    String feedback,
    String newRating,
    String patientUid,
    String feedBackAppointmentId,
    BuildContext context,
  ) async {
    bool isSuccess = false;
    try {
      String feedBackId = const Uuid().v1();
      FeedBackModel feedBackModel = FeedBackModel(
        feedBackId: feedBackId,
        patientUid: patientUid,
        patientName: patientName,
        patientPhone: patientPhone,
        staffUid: staffUid,
        staffName: staffName,
        staffPhone: staffPhone,
        feedBack: feedback,
        dateOfFeedback: DateFormat('dd-MM-yyyy').format(
          DateTime.now(),
        ),
        feedbackAppointmentId: feedBackAppointmentId,
      );
      FirebaseFirestore.instance
          .collection('feedbacks')
          .doc(feedBackId)
          .set(feedBackModel.toMap());
      FirebaseFirestore.instance.collection('staff').doc(staffUid).update({
        "staffRating": newRating,
      });
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(feedBackAppointmentId)
          .update({
        "isFeedBackGiven": true,
      });
      isSuccess = true;
      return isSuccess;
    } catch (e) {
      if (kDebugMode) {
        print('...');
        print(e.toString());
      }
      Shared().snackbar(context, 'Some Error Occurred. Try again later');
      return false;
    }
  }

  Future<bool> updateDuration(
    String duration,
    String appointmentId,
    BuildContext context,
  ) async {
    if (kDebugMode) {
      print(appointmentId);
      print("duration = ");
      print(duration);
    }
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({
        'duration': duration,
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        print("app");
        print(appointmentId);
      }
      Shared().snackbar(context, 'Some Error Occurred');
      return false;
    }
  }
}
