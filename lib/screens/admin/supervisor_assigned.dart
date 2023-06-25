import 'package:clinic/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Widgets/supervisor_activity_box.dart';
import '../../models/appointment_model.dart';

class SupervisorAssigned extends StatefulWidget {
  const SupervisorAssigned({Key? key}) : super(key: key);

  @override
  State<SupervisorAssigned> createState() => _SupervisorAssignedState();
}

class _SupervisorAssignedState extends State<SupervisorAssigned> {
  bool isLoading = false;
  List<AppointmentModel> assignedAppointments = [];
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    assignedAppointments = Provider.of<List<AppointmentModel>>(context)
        .where((element) => element.status == 'assigned')
        .toList();
    DateFormat format = DateFormat('dd-MM-yyyy');
    assignedAppointments.sort((a, b) {
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
      print(assignedAppointments);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: assignedAppointments.isEmpty
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            body: assignedAppointments.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : ListView.builder(
                    itemCount: assignedAppointments.length,
                    itemBuilder: (context, index) {
                      return contain(
                        assignedAppointments[index].patientName,
                        assignedAppointments[index].patientPhone,
                        '${assignedAppointments[index].dateOfAppointment} ${assignedAppointments[index].timeOfAppointment}',
                        assignedAppointments[index].reason,
                        assignedAppointments[index].baseFee,
                        assignedAppointments[index].assignedStaffName,
                        assignedAppointments[index].status,
                      );
                    }),
          );
  }
}
