import 'package:clinic/Widgets/current_appointment_box.dart';
import 'package:clinic/shared/loading.dart';
import 'package:clinic/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../shared/typography.dart';

class CurrentAppointments extends StatefulWidget {
  const CurrentAppointments({Key? key}) : super(key: key);

  @override
  State<CurrentAppointments> createState() => _CurrentAppointmentsState();
}

class _CurrentAppointmentsState extends State<CurrentAppointments> {
  bool isLoading = false;
  List<AppointmentModel> allAppointments = [];
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allAppointments = Provider.of<List<AppointmentModel>>(context)
        .where((element) =>
            element.patientUid == FirebaseAuth.instance.currentUser!.uid)
        .where((element) =>
            (element.status == 'pending' || element.status == 'assigned'))
        .toList();
    allAppointments.sort(
      (a, b) {
        DateFormat format = DateFormat('dd-MM-yyyy');
        var aDate = format.parse(a.dateOfAppointment);
        var bDate = format.parse(b.dateOfAppointment);
        return -aDate.compareTo(bDate);
      },
    );
    if (kDebugMode) {
      print(allAppointments);
    }
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: allAppointments.isEmpty
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Current Appointments',
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
            : allAppointments.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 65.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 3)
                              ]),
                          child: Container(
                            margin: EdgeInsets.only(top: 7.5.h, left: 10.w),
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      ' Note :- \n 1) Share the secret Otp only after the payment is complete . \n 2) Otp will be available on the last date of the appointment.',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 13.sp)),
                            ),
                          ),
                        ), //
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allAppointments.length,
                            itemBuilder: (context, index) {
                              return appointments(
                                allAppointments[index].dateOfAppointment,
                                allAppointments[index].timeOfAppointment,
                                allAppointments[index].reason,
                                allAppointments[index].assignedStaffName,
                                allAppointments[index].baseFee,
                                allAppointments[index].status,
                                allAppointments[index].assignedStaffPhone,
                                context,
                                allAppointments[index].appointmentId,
                                allAppointments[index].assignedStaffUid,
                                allAppointments[index].secretOtp,
                                allAppointments[index].duration,
                              );
                            }),
                      ],
                    ),
                  ));
  }
}
