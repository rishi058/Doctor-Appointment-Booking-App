import 'package:clinic_app/Widgets/appointment_history_box.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:clinic_app/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../shared/colors.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({Key? key}) : super(key: key);

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  bool isLoading = false;
  List<AppointmentModel> appointMentHistory = [];
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    appointMentHistory = Provider.of<List<AppointmentModel>>(context)
        .where((element) =>
            element.patientUid == FirebaseAuth.instance.currentUser!.uid)
        .where((element) =>
            element.status == 'completed' || element.status == 'cancelled')
        .toList();
    appointMentHistory.sort(
      (a, b) {
        DateFormat format = DateFormat('yyyy-MM-dd');
        var aDate = format.parse(a.dateOfAppointment);
        var bDate = format.parse(b.dateOfAppointment);
        return -aDate.compareTo(bDate);
      },
    );
    if (kDebugMode) {
      print(appointMentHistory);
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
        backgroundColor: appointMentHistory.isEmpty
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
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
          elevation: 2,
          centerTitle: true,
          title: Text(
            'Appointment History',
            style: theme(sz: 18),
          ),
        ),
        body: isLoading
            ? const Loading()
            : appointMentHistory.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : ListView.builder(
                    itemCount: appointMentHistory.length,
                    itemBuilder: (context, index) {
                      return appointmentHistory(
                          appointMentHistory[index].dateOfAppointment,
                          appointMentHistory[index].timeOfAppointment,
                          appointMentHistory[index].reason,
                          appointMentHistory[index].assignedStaffName,
                          appointMentHistory[index].baseFee,
                          appointMentHistory[index].status,
                          appointMentHistory[index].isFeedBackGiven,
                          appointMentHistory[index].assignedStaffUid,
                          appointMentHistory[index].appointmentId,
                          context);
                    }));
  }
}
