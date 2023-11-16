import 'package:clinic_app/Widgets/pending_appointments_box.dart';
import 'package:clinic_app/models/appointment_model.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class PendingAppointments extends StatefulWidget {
  const PendingAppointments({Key? key}) : super(key: key);

  @override
  State<PendingAppointments> createState() => _PendingAppointmentsState();
}

class _PendingAppointmentsState extends State<PendingAppointments> {
  bool isLoading = false;
  List<AppointmentModel> pendingAppointmentsList = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    pendingAppointmentsList = Provider.of<List<AppointmentModel>>(context)
        .where((element) => element.status == 'pending')
        .toList();
    pendingAppointmentsList.sort((a, b) {
      DateFormat format = DateFormat('dd-MM-yyyy');
      var aDate = format.parse(a.dateOfAppointment);
      var bDate = format.parse(b.dateOfAppointment);
      return aDate.compareTo(bDate);
    });
    if (kDebugMode) {
      print(pendingAppointmentsList);
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
      backgroundColor: pendingAppointmentsList.isEmpty
          ? Colors.white
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Pending Appointments',
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
          : pendingAppointmentsList.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/void.png'),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: pendingAppointmentsList.length,
                  itemBuilder: (context, index) {
                    return pendingAppointments(
                      pendingAppointmentsList[index].dateOfAppointment,
                      pendingAppointmentsList[index].timeOfAppointment,
                      pendingAppointmentsList[index].patientName,
                      pendingAppointmentsList[index].patientPhone,
                      pendingAppointmentsList[index].patientAddress,
                      pendingAppointmentsList[index].reason,
                      pendingAppointmentsList[index].appointmentId,
                      context,
                    );
                  }),
    );
  }
}
