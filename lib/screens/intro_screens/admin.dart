import 'package:clinic_app/services/authenticaton.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../services/shared_pref.dart';
import '../../shared/user_type.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool isLoading = false;
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    isLoading = false;
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
              Text(
                "Welcome Admin",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Sign In To Continue",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 3),
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue.shade900),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Password",
                  ),
                ),
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
                            await Authentication()
                                .loginAdmin(
                              password.text,
                              context,
                            )
                                .then((value) {
                              if (value) {
                                HelperFunctions.saveUserTypeStatus(
                                    USER().admin);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    'admin-dashboard', (route) => false);
                              }
                            });
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text("Admin Login")),
                    ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('forgot-password');
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
