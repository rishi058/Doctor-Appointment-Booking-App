import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/services/database.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({Key? key}) : super(key: key);

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    countryController.dispose();
    phoneController.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    countryController.text = "+91";
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
          'Add a staff',
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
                "Register a Staff",
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
                        controller: namecontroller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                        ),
                      ),
                    ),
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
                        controller: emailcontroller,
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
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password for staff",
                        ),
                      ),
                    ),
                  ],
                ),
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
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    )
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
                        onPressed: () {
                          if (namecontroller.text.isNotEmpty &&
                              emailcontroller.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            AwesomeDialog(
                              btnOkColor: primaryColor,
                              btnCancelColor: Colors.grey,
                              dialogType: DialogType.question,
                              title: 'Add Staff?',
                              desc: 'Are you sure you want to add this staff?',
                              context: context,
                              btnOkOnPress: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                bool isSuccess = await Database().addStaff(
                                  namecontroller.text,
                                  emailcontroller.text.trim(),
                                  passwordcontroller.text.trim(),
                                  '${countryController.text.trim()}${phoneController.text.trim()}',
                                  context,
                                );
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    namecontroller.text = "";
                                    emailcontroller.text = "";
                                    passwordcontroller.text = "";
                                    phoneController.text = "";
                                    isLoading = false;
                                  });
                                });
                                if (isSuccess) {
                                  if (!mounted) return;
                                  Shared().snackbar(
                                      context, 'Staff Added Successfully');
                                }
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          } else {
                            AwesomeDialog(
                                    dialogType: DialogType.warning,
                                    title: 'Please Enter all the details.',
                                    context: context)
                                .show();
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: const Text("Register")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
