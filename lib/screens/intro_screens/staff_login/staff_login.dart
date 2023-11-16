// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/services/Shared_Pref.dart';
import 'package:clinic_app/services/authenticaton.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/colors.dart';
import '../../../shared/user_type.dart';

class StaffPhone extends StatefulWidget {
  const StaffPhone({Key? key}) : super(key: key);

  @override
  State<StaffPhone> createState() => _StaffPhoneState();
}

class _StaffPhoneState extends State<StaffPhone> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                height: 10,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue.shade900),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue.shade900),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: passwordcontroller,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: isLoading
                    ? const Loading()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          if (emailcontroller.text.isEmpty ||
                              passwordcontroller.text.isEmpty) {
                            AwesomeDialog(
                                    dialogType: DialogType.warning,
                                    dismissOnTouchOutside: false,
                                    dismissOnBackKeyPress: false,
                                    title: 'Please Enter all the fields.',
                                    context: context)
                                .show();
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            bool isSuccess = await Authentication().loginStaff(
                              emailcontroller.text,
                              passwordcontroller.text,
                              context,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            if (isSuccess) {
                              HelperFunctions.saveUserTypeStatus(USER().staff);
                              Navigator.of(context)
                                  .pushReplacementNamed('staff-dashboard');
                            }
                          }
                        },
                        child: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
