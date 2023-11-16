import 'package:clinic_app/Widgets/all_appointments_box.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';
import '../../models/appointment_model.dart';

class AllAppointments extends StatefulWidget {
  const AllAppointments({Key? key}) : super(key: key);

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
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
        .where((element) => element.status == 'completed')
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
        elevation: 2,
        title: Text(
          'Completed Appointments',
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
