import 'package:clinic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/drawer.dart';

class MyWelcomePage1 extends StatefulWidget {
  const MyWelcomePage1({Key? key}) : super(key: key);

  @override
  State<MyWelcomePage1> createState() => _MyWelcomePage1State();
}

class _MyWelcomePage1State extends State<MyWelcomePage1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSplash = false;

  Widget text(String value) {
    return Container(
      decoration: BoxDecoration(
          color: buttonColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(35),
        border: Border.all(width: 0.6, color: buttonColor)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: value,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp
            )),
      ),
    );
  }

  @override
  void initState() {
    isSplash = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isSplash = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: buttonColor,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Image.asset(
              'assets/1.png',
              width: 140.w,
              height: 140.w,
            ),
                SizedBox(
                  height: 20.h,
                ),
           text('Authentic Physiotherapy Clinic "Home Care Services " is an exclusive service provided by highly trained and skilled Physiotherapist of Authentic group. We are into this field since the year 2008 . We assure you of the quality physio care.'),
            SizedBox(
              height: 50.h,
            ),
            const Text(
              "Choose One",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.pushNamed(context, "patient-phone");
                  },
                  child: const Text("Patient")),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('OR'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "welcome-page2");
                  },
                  child: const Text("Others")),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: 'By Signing in you agree to our',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
