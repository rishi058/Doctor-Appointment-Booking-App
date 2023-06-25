import 'package:clinic/screens/admin/supervisor_assigned.dart';
import 'package:clinic/screens/admin/supervisor_pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class SupervisorNavBar extends StatefulWidget {
  const SupervisorNavBar({Key? key}) : super(key: key);

  @override
  State<SupervisorNavBar> createState() => _SupervisorNavBarState();
}

class _SupervisorNavBarState extends State<SupervisorNavBar> {
  int selectedIndex = 0;

  static const List<Widget> pageList = <Widget>[
    SupervisorPending(),
    SupervisorAssigned(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Supervisor Activity',
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
      body: pageList[selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 45.h,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: selectedIndex == 0
                      ? activeButton(Icons.pending_actions, '  Pending')
                      : const Center(
                          child: Icon(Icons.pending_actions),
                        )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: selectedIndex == 1
                      ? activeButton(
                          Icons.assignment_ind_outlined, '  Assigned')
                      : const Center(
                          child: Icon(Icons.assignment_ind_outlined),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget activeButton(IconData ic, String text) {
  return Container(
    height: 30.h,
    margin: EdgeInsets.symmetric(horizontal: 30.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: buttonColor.withOpacity(0.4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(ic),
        Text(text),
      ],
    ),
  );
}
