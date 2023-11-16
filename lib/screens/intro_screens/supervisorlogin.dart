import 'package:clinic_app/services/authenticaton.dart';
import 'package:clinic_app/services/shared_pref.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/user_type.dart';

class MySupervisor extends StatefulWidget {
  const MySupervisor({Key? key}) : super(key: key);

  @override
  State<MySupervisor> createState() => _MySupervisorState();
}

class _MySupervisorState extends State<MySupervisor> {
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
              const Text(
                "Welcome Supervisor",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Sign In To Continue ",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 55,
                  padding: const EdgeInsets.only(left: 20, top: 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blue.shade900),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Supervisor Password",
                    ),
                  )),
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
                                .loginSupervisor(
                              password.text,
                              context,
                            )
                                .then((value) {
                              if (value) {
                                HelperFunctions.saveUserTypeStatus(
                                    USER().supervisor);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'supervisor-dashboard', (route) => false);
                              }
                            });
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text("Supervisor Login")),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
