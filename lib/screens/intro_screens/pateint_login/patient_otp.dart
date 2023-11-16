import 'package:clinic_app/services/database.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../shared/colors.dart';
import '../../../shared/user_type.dart';
import '../../../services/shared_pref.dart';

class PatientVerification extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const PatientVerification(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  State<PatientVerification> createState() => _PatientVerificationState();
}

class _PatientVerificationState extends State<PatientVerification> {
  bool isLoading = false;
  String smsCode = '';

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.verificationId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "patient-phone");
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryColor,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/1.png',
                width: 180.w,
                height: 180.w,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter the OTP!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin) {
                  if (kDebugMode) {
                    print(pin);
                  }
                  setState(() {
                    smsCode = pin;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Loading()
                  : SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final cred = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: smsCode,
                            );
                            try {
                              // signing up the user
                              await FirebaseAuth.instance
                                  .signInWithCredential(cred);

                              // storing userData
                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              Database().storeUser(widget.phoneNumber, uid);
                              HelperFunctions.saveUserTypeStatus(
                                  USER().patient);
                              if (!mounted) return;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'patient-dashboard', (route) => false);
                            } catch (e) {
                              Shared().snackbar(context, 'Some error Occurred');
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text("Verify Phone Number")),
                    ),
              Row(
                children: [
                  TextButton(
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "patient-phone");
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
