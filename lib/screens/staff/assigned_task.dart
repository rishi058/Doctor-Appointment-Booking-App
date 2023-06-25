import 'package:clinic/Widgets/current_appointments_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/appointment_model.dart';
import '../../shared/colors.dart';
import '../../shared/loading.dart';
import '../../shared/typography.dart';

class AssignedTask extends StatefulWidget {
  const AssignedTask({Key? key}) : super(key: key);

  @override
  State<AssignedTask> createState() => _AssignedTaskState();
}

class _AssignedTaskState extends State<AssignedTask> {
  bool isLoading = false;
  List<AppointmentModel> assignedAppointmetnsList = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    assignedAppointmetnsList = Provider.of<List<AppointmentModel>>(context)
        .where((element) =>
            element.assignedStaffUid ==
                FirebaseAuth.instance.currentUser!.uid &&
            element.status == 'assigned')
        .toList();
    assignedAppointmetnsList.sort((a, b) {
      DateFormat format = DateFormat('dd-MM-yyyy');
      var aDate = format.parse(a.dateOfAppointment);
      var bDate = format.parse(b.dateOfAppointment);
      return aDate.compareTo(bDate);
    });
    if (kDebugMode) {
      print(assignedAppointmetnsList);
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
      backgroundColor: assignedAppointmetnsList.isEmpty
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
          'Assigned Appointment',
          style: theme(sz: 18),
        ),
      ),
      body: isLoading
          ? const Loading()
          : assignedAppointmetnsList.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/void.png'),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: assignedAppointmetnsList.length,
                  itemBuilder: (context, index) {
                    return currentAppointments(
                      assignedAppointmetnsList[index].dateOfAppointment,
                      assignedAppointmetnsList[index].timeOfAppointment,
                      assignedAppointmetnsList[index].patientName,
                      assignedAppointmetnsList[index].patientPhone,
                      assignedAppointmetnsList[index].patientAddress,
                      assignedAppointmetnsList[index].reason,
                      assignedAppointmetnsList[index].baseFee,
                      assignedAppointmetnsList[index].assignedStaffName,
                      "staff",
                      context,
                      assignedAppointmetnsList[index].appointmentId,
                      assignedAppointmetnsList[index].secretOtp,
                      assignedAppointmetnsList[index].duration,
                    );
                  }),
    );
  }
}
