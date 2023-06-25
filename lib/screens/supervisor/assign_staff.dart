import 'package:clinic/Widgets/dialog_to_assign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/select_staff_tile.dart';
import '../../models/staff_model.dart';
import '../../shared/colors.dart';
import '../../shared/loading.dart';
import '../../shared/typography.dart';

class AssignStaff extends StatefulWidget {
  final String appointmentId;
  const AssignStaff({
    Key? key,
    required this.appointmentId,
  }) : super(key: key);

  @override
  State<AssignStaff> createState() => _AssignStaffState();
}

class _AssignStaffState extends State<AssignStaff> {
  bool isLoading = false;
  List<StaffModel> staffList = [];
  String amount = "";

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    staffList = Provider.of<List<StaffModel>>(context);
    if (kDebugMode) {
      print(staffList);
    }
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  popUpDialog(String staffUid, String staffName, String staffEmail, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Enter Base Fee",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          amount = val;
                        });
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                      decoration: textInputDecoration.copyWith(
                          labelText: "Amount",
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Container(
                            height: 37.h,
                            width: 100.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: buttonColor,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: buttonColor, fontSize: 17.sp),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                      GestureDetector(
                        child: Container(
                          height: 37.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                              child: Text(
                            'Submit',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.sp),
                          )),
                        ),
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          DocumentSnapshot documentSnapshot =
                              await FirebaseFirestore.instance
                                  .collection('appointments')
                                  .doc(widget.appointmentId)
                                  .get();
                          String patientUid = (documentSnapshot.data()!
                              as Map<String, dynamic>)['patientUid'];
                          DocumentSnapshot snap = await FirebaseFirestore
                              .instance
                              .collection('PatientTokens')
                              .doc(patientUid)
                              .get();
                          String token =
                              (snap.data()! as Map<String, dynamic>)['token'];
                          // ignore: use_build_context_synchronously
                          displayDialog(
                              amount, widget.appointmentId, staffUid, context,token, staffName, staffEmail);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: staffList.isEmpty
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 2,
          title: Text(
            'Select a Staff',
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
        body: isLoading
            ? const Loading()
            : staffList.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : ListView.builder(
                    itemCount: staffList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          popUpDialog(staffList[index].staffUid, staffList[index].staffName, staffList[index].email, context);
                        },
                        child: staffTile(
                            staffList[index].staffName,
                            staffList[index].staffPhone,
                            staffList[index].staffAddress,
                            staffList[index].staffProfPic),
                      );
                    }));
  }
}
