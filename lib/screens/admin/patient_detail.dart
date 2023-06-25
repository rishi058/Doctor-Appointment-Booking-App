import 'package:clinic/Widgets/all_appointments_box.dart';
import 'package:clinic/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/appointment_model.dart';
import '../../shared/colors.dart';
import '../../shared/loading.dart';
import '../../shared/typography.dart';

class PatientDetail extends StatefulWidget {
  const PatientDetail({Key? key, required this.patient}) : super(key: key);

  final PatientModel patient;

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  bool isLoading = false;
  List<AppointmentModel> allAppointmentsList = [];
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allAppointmentsList = Provider.of<List<AppointmentModel>>(context)
        .where((element) =>
            element.patientUid == widget.patient.patientUid &&
            element.status == 'completed')
        .toList();
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Patient Detail',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            myWidget(widget.patient.patientName, widget.patient.patientPhone,
                widget.patient.patientAddress, widget.patient.patientAge),
            const Divider(thickness: 1.6),
            Text(
              'Past Appointments(${allAppointmentsList.length})',
              style: theme(sz: 18),
            ),
            //ListViewBuilder...
            SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Loading()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allAppointmentsList.length,
                        itemBuilder: (context, index) {
                          return allAppointment(
                            allAppointmentsList[index].dateOfAppointment,
                            allAppointmentsList[index].timeOfAppointment,
                            allAppointmentsList[index].reason,
                            allAppointmentsList[index].assignedStaffName,
                            allAppointmentsList[index].baseFee,
                            allAppointmentsList[index].patientName,
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}

Widget myWidget(String name, String phone, String address, String age) {
  return Column(
    children: [
      Container(
        width: 110.h,
        height: 110.h,
        margin: EdgeInsets.only(top: 20.h),
        decoration: BoxDecoration(
            border: Border.all(width: 1.7, color: buttonColor),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage('assets/profile.png'),
            )),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 17.w),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: Text(
                'Name : ',
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
            SizedBox(
              width: 230.w,
              child: Text(
                name,
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 17.w),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: Text(
                'Age : ',
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
            SizedBox(
              width: 230.w,
              child: Text(
                age,
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 17.w),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: Text(
                'Contact No. : ',
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
            SizedBox(
              width: 230.w,
              child: Text(
                phone,
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 17.w),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: Text(
                'Address : ',
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
            SizedBox(
              width: 230.w,
              child: Text(
                address,
                style: theme(sz: 14, clr: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
