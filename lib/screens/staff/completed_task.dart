import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Widgets/all_appointments_box.dart';
import '../../models/appointment_model.dart';
import '../../shared/colors.dart';
import '../../shared/loading.dart';
import '../../shared/typography.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  bool isLoading = false;
  List<AppointmentModel> completedAppointments = [];
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    completedAppointments = Provider.of<List<AppointmentModel>>(context)
        .where((element) =>
            element.assignedStaffUid ==
                FirebaseAuth.instance.currentUser!.uid &&
            element.status == 'completed')
        .toList();
    DateFormat format = DateFormat('dd-MM-yyyy');
    completedAppointments.sort((a, b) {
      var aDate = format.parse(a.dateOfAppointment);
      var bDate = format.parse(b.dateOfAppointment);
      return -aDate.compareTo(bDate);
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    if (kDebugMode) {
      print(completedAppointments);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: completedAppointments.isEmpty
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
          'Completed Appointment',
          style: theme(sz: 18),
        ),
      ),
      body: isLoading
          ? const Loading()
          : completedAppointments.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image(image: AssetImage('assets/void.png'))],
                )
              : ListView.builder(
                  itemCount: completedAppointments.length,
                  itemBuilder: (context, index) {
                    return allAppointment(
                      completedAppointments[index].dateOfAppointment,
                      completedAppointments[index].timeOfAppointment,
                      completedAppointments[index].reason,
                      completedAppointments[index].assignedStaffName,
                      completedAppointments[index].baseFee,
                      completedAppointments[index].patientName,
                    );
                  }),
    );
  }
}
