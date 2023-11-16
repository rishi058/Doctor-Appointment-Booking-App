import 'package:clinic_app/Widgets/current_appointments_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/appointment_model.dart';
import '../../shared/colors.dart';
import '../../shared/loading.dart';
import '../../shared/typography.dart';

class CurrentAppointmentsSupervisor extends StatefulWidget {
  const CurrentAppointmentsSupervisor({Key? key}) : super(key: key);

  @override
  State<CurrentAppointmentsSupervisor> createState() =>
      _CurrentAppointmentsSupervisorState();
}

class _CurrentAppointmentsSupervisorState
    extends State<CurrentAppointmentsSupervisor> {
  bool isLoading = false;
  List<AppointmentModel> currentAppointmetnsList = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    currentAppointmetnsList = Provider.of<List<AppointmentModel>>(context)
        .where((element) => element.status == 'assigned')
        .toList();
    currentAppointmetnsList.sort((a, b) {
      DateFormat format = DateFormat('dd-MM-yyyy');
      var aDate = format.parse(a.dateOfAppointment);
      var bDate = format.parse(b.dateOfAppointment);
      return -aDate.compareTo(bDate);
    });
    if (kDebugMode) {
      print(currentAppointmetnsList);
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
      backgroundColor: currentAppointmetnsList.isEmpty
          ? Colors.white
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 2,
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
          : currentAppointmetnsList.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/void.png'),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: currentAppointmetnsList.length,
                  itemBuilder: (context, index) {
                    return currentAppointments(
                      currentAppointmetnsList[index].dateOfAppointment,
                      currentAppointmetnsList[index].timeOfAppointment,
                      currentAppointmetnsList[index].patientName,
                      currentAppointmetnsList[index].patientPhone,
                      currentAppointmetnsList[index].patientAddress,
                      currentAppointmetnsList[index].reason,
                      currentAppointmetnsList[index].baseFee,
                      currentAppointmetnsList[index].assignedStaffName,
                      "",
                      context,
                      currentAppointmetnsList[index].appointmentId,
                      currentAppointmetnsList[index].secretOtp,
                      currentAppointmetnsList[index].duration,
                    );
                  }),
    );
  }
}
