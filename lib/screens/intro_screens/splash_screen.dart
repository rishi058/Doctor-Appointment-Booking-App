import 'dart:async';

import 'package:clinic_app/screens/intro_screens/operator_options/operator_page1.dart';
import 'package:clinic_app/screens/patient/dashborad.dart';
import 'package:clinic_app/shared/route_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/database.dart';
import '../../services/shared_pref.dart';
import '../../shared/user_type.dart';
import '../admin/admin_dashboard.dart';
import '../staff/staff_dashboard.dart';
import '../supervisor/supervisor_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userType;

  void fun() {
    Timer(const Duration(seconds: 2), () {
      if (userType == USER().patient) {
        goto(context, const PatientDashboard());
      } else if (userType == USER().staff) {
        goto(context, const StaffDashboard());
      } else if (userType == USER().supervisor) {
        goto(context, const SupervisorDashboard());
      } else if (userType == USER().admin) {
        goto(context, const AdminDashboard());
      } else {
        goto(context, const MyWelcomePage1());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserTypeStatus().then((value) {
      setState(() {
        userType = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fun();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(18, 49, 114, 1), Colors.deepPurple])),
      child: Center(
        child: SizedBox(
          height: 110.w,
          width: 110.w,
          child: Image.asset('assets/1.png'),
        ),
      ),
    );
  }
}
