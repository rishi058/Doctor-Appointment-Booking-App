import 'dart:async';
import 'dart:io';

import 'package:clinic_app/services/authenticaton.dart';
import 'package:clinic_app/shared/colors.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/Shared_Pref.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

void getData() async {
  Timer(const Duration(seconds: 3), () {
    exit(0);
  });
}

class _MyDrawerState extends State<MyDrawer> {
  bool vis = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserTypeStatus().then((value) {
      setState(() {
        if (value != null && value.isNotEmpty) {
          vis = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 160.w,
              width: 160.w,
              child: Image.asset('assets/1.png'),
            ),
            const Divider(thickness: 1),
            vis
                ? GestureDetector(
                    onTap: () {
                      logout(context);
                    },
                    child: tilee(Icons.logout_outlined, 'Log Out'),
                  )
                : const SizedBox.shrink(),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'about-us');
                },
                child: tilee(Icons.info, 'About Us')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'contact-us');
                },
                child: tilee(Icons.contact_support, 'Contact Us')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'privacy-policy');
                },
                child: tilee(Icons.policy_outlined, 'Privacy Policy')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'terms');
                },
                child:
                    tilee(Icons.rate_review_outlined, 'Terms and Conditions')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'cancel-refund');
                },
                child: tilee(Icons.not_listed_location_outlined,
                    'Cancellation/Refund Policy')),
          ],
        ),
      ),
    );
  }
}

Widget tilee(IconData ic, String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 13.w),
    padding: EdgeInsets.all(12.5.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueGrey.withOpacity(0.2),
    ),
    child: Row(
      children: [
        Icon(ic, color: buttonColor),
        SizedBox(width: 10.w),
        Text(
          text,
          style: theme(sz: 11),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

void logout(BuildContext ctx) {
  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 150.0,
            width: 320.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(18, 7, 0, 7),
                      child: Text(
                        'Log Out ?',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(18, 2.5, 0, 15),
                      child: const Text(
                        'Are you sure want to Log Out ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: buttonColor,
                              ),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                      GestureDetector(
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: const Center(
                              child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        onTap: () async {
                          Authentication.signOut(context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
