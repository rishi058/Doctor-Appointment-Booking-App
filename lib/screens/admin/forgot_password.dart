import 'package:clinic_app/services/authenticaton.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController supervisorEmailcontroller = TextEditingController();
  TextEditingController adminEmailcontroller = TextEditingController();
  bool isAdminLoading = false;
  bool isSupervisorLoading = false;

  @override
  void dispose() {
    supervisorEmailcontroller.dispose();
    adminEmailcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    supervisorEmailcontroller.text = "rishi.helloworld@gmail.com";
    adminEmailcontroller.text = "rishiqwerty01@gmail.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Change Password',
          style: theme(sz: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryColor,
          ),
        ),
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
                width: 150.w,
                height: 150.w,
              ),
              const SizedBox(height: 40),
              const Text(
                "Change Password (Supervisor)",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        enabled: false,
                        controller: supervisorEmailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: isSupervisorLoading
                    ? const Loading()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          setState(() {
                            isSupervisorLoading = true;
                          });
                          await Authentication()
                              .resetPassword(
                            supervisorEmailcontroller.text,
                            context,
                          )
                              .then((value) {
                            if (value) {
                              Shared()
                                  .snackbar(context, 'Otp send Successfully');
                            } else {
                              Shared()
                                  .snackbar(context, 'Some Error Occurred!');
                            }
                          });
                          setState(() {
                            isSupervisorLoading = false;
                          });
                        },
                        child: const Text("Send OTP")),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Change Password (Admin)",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        enabled: false,
                        controller: adminEmailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: isAdminLoading
                    ? const Loading()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          setState(() {
                            isAdminLoading = true;
                          });
                          await Authentication()
                              .resetPassword(
                            adminEmailcontroller.text,
                            context,
                          )
                              .then((value) {
                            if (value) {
                              Shared()
                                  .snackbar(context, 'Otp send Successfully');
                            } else {
                              Shared()
                                  .snackbar(context, 'Some Error Occurred!');
                            }
                          });
                          setState(() {
                            isAdminLoading = false;
                          });
                        },
                        child: const Text("Send OTP")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
