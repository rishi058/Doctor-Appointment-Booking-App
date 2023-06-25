import 'package:clinic/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Widgets/supervisor_activity_box.dart';
import '../../models/appointment_model.dart';

class SupervisorPending extends StatefulWidget {
  const SupervisorPending({Key? key}) : super(key: key);

  @override
  State<SupervisorPending> createState() => _SupervisorPendingState();
}

class _SupervisorPendingState extends State<SupervisorPending> {
  bool isLoading = false;
  List<AppointmentModel> pendingAppointments = [];
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    pendingAppointments = Provider.of<List<AppointmentModel>>(context)
        .where((element) => element.status == 'pending')
        .toList();
    DateFormat format = DateFormat('dd-MM-yyyy');
    pendingAppointments.sort((a, b) {
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
      print(pendingAppointments);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: pendingAppointments.isEmpty
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            body: pendingAppointments.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : ListView.builder(
                    itemCount: pendingAppointments.length,
                    itemBuilder: (context, index) {
                      return contain(
                        pendingAppointments[index].patientName,
                        pendingAppointments[index].patientPhone,
                        '${pendingAppointments[index].dateOfAppointment} ${pendingAppointments[index].timeOfAppointment}',
                        pendingAppointments[index].reason,
                        pendingAppointments[index].baseFee,
                        pendingAppointments[index].assignedStaffName,
                        pendingAppointments[index].status,
                      );
                    }),
          );
  }
}
