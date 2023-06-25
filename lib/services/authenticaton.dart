import 'package:clinic/models/patient_model.dart';
import 'package:clinic/models/staff_model.dart';
import 'package:clinic/screens/intro_screens/pateint_login/patient_otp.dart';
import 'package:clinic/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'shared_pref.dart';

class Authentication {
  final auth = FirebaseAuth.instance;

  // getting user details
  Future<PatientModel> getUserDetails() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('patients')
        .doc(currentUser.uid)
        .get();
    return PatientModel.fromSnap(snapshot);
  }

  // getting staff details
  Future<StaffModel> getStaffDetails() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('staff')
        .doc(currentUser.uid)
        .get();
    return StaffModel.fromSnap(snapshot);
  }

  // verify user phone
  Future<bool> verifyPhone(BuildContext context, String phoneNumber) async {
    bool isSuccess = false;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(
          seconds: 20,
        ),
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          Shared().snackbar(context, 'Verification Failed');
        },
        codeSent: (verificationId, forceResendingToken) {
          isSuccess = true;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PatientVerification(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (e) {
          Shared().snackbar(context, 'Timed Out.Try again Later.');
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Shared().snackbar(context, 'Some error Occurred');
    }

    return isSuccess;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      await HelperFunctions.saveUserTypeStatus("").then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('welcome-page1', (route) => false);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Error in Signing Out ! Try Again !! ',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  // login staff
  Future<bool> loginStaff(
      String email, String password, BuildContext context) async {
    bool isSuccess = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        isSuccess = true;
      });
      return isSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Shared().snackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Shared().snackbar(context, 'Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      Shared().snackbar(context, 'Some Error Occurred');
      return false;
    }
  }

  // login admin
  Future<bool> loginAdmin(String password, BuildContext context) async {
    bool isSuccess = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: "clinic9190@gmail.com",
        password: password,
      )
          .then((value) {
        isSuccess = true;
      });
      return isSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Shared().snackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Shared().snackbar(context, 'Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      Shared().snackbar(context, 'Some Error Occurred');
      return false;
    }
  }

  Future<bool> loginSupervisor(String password, BuildContext context) async {
    bool isSuccess = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: "supervisor9190@gmail.com",
        password: password,
      )
          .then((value) {
        isSuccess = true;
      });
      return isSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Shared().snackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Shared().snackbar(context, 'Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      Shared().snackbar(context, 'Some Error Occurred');
      return false;
    }
  }

  // change password supervisor
  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      Shared().snackbar(context, e.code.toString());
      return false;
    } catch (e) {
      Shared().snackbar(context, e.toString());
      return false;
    }
  }
}
