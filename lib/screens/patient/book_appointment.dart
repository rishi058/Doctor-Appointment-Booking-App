import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/shared/colors.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:clinic_app/models/patient_model.dart';
import 'package:clinic_app/services/database.dart';
import 'package:clinic_app/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/services/firebase_push_notification.dart';
import 'package:clinic_app/services/email_js.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late PatientModel patient;
  final name = TextEditingController();
  final phoneNo = TextEditingController();
  final address = TextEditingController();
  final reason = TextEditingController();
  DateTime? _selectedDate;
  String? time;
  bool isLoading = true;

  @override
  void initState() {
    isLoading = true;
    setData();
    super.initState();
  }

  void setData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await Database().getUser(uid).then((value) {
      if (value != null) {
        setState(() {
          patient = value;
          name.text = patient.patientName;
          phoneNo.text = patient.patientPhone;
          address.text = patient.patientAddress;
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    name.dispose();
    phoneNo.dispose();
    reason.dispose();
    address.dispose();
    super.dispose();
  }

  String timeToString(TimeOfDay time) {
    String x = "";
    x += time.hour.toString();
    x += " : ";
    x += time.minute.toString();
    return x;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _timePicker(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200.h,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newDateTime) {
                      time = DateFormat.jm().format(newDateTime);
                    },
                    use24hFormat: false,
                    minuteInterval: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    time ??= DateFormat.jm().format(DateTime.now());
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Container(
                    height: 25.h,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: buttonColor),
                    margin:
                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 5.h),
                    child: Center(
                        child: Text(
                      'OK',
                      style: theme(sz: 16, clr: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Book an Appointment',
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
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Name ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Name', border: InputBorder.none),
                          controller: name,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Contact No.  ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Contact No.',
                              border: InputBorder.none),
                          controller: phoneNo,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Address ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Address', border: InputBorder.none),
                          controller: address,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Reason of Home Visit ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Reason of Visit',
                              border: InputBorder.none),
                          controller: reason,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'No Date Chosen!'
                                : 'Picked Date :  ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
                          ),
                        ),
                        InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 3.w),
                              child: Text(
                                'Select Date',
                                style: theme(sz: 15),
                              ),
                            ),
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              _presentDatePicker();
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            time == null
                                ? 'No Time Chosen!'
                                : 'Picked Time :  $time',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _timePicker(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 3.w),
                            child: Text(
                              'Select Time',
                              style: theme(sz: 15),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (name.text.isEmpty ||
              phoneNo.text.isEmpty ||
              address.text.isEmpty ||
              reason.text.isEmpty ||
              _selectedDate == null ||
              time == null) {
            AwesomeDialog(
              dialogType: DialogType.error,
              title: 'Please enter all the fields',
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              animType: AnimType.leftSlide,
              context: context,
            ).show();
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
            return;
          }
          setState(() {
            isLoading = true;
          });
          bool isSuccess = await Database().bookAppointMent(
            name.text.trim(),
            phoneNo.text.trim(),
            address.text.trim(),
            reason.text.trim(),
            DateFormat('dd-MM-yyyy').format(_selectedDate!),
            time!,
            context,
          );
          setState(() {
            isLoading = false;
          });
          if (!mounted) return;
          Navigator.of(context).pop();
          if (isSuccess) {
            Shared().snackbar(
              context,
              'Appointment Request Successful',
            );
            sendEmailAboutNewAppointment(name.text, phoneNo.text);
            notificationSender();
          } else {
            Shared().snackbar(
              context,
              'Appointment booking failed',
            );
          }
        },
        child: isLoading
            ? const Loading()
            : Container(
                height: 35.h,
                margin: EdgeInsets.only(right: 13.w, left: 13.w, bottom: 13.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.w),
                  color: buttonColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Confirm  Booking',
                      style: theme(sz: 15, clr: Colors.white, sp: 2),
                    )),
              ),
      ),
    );
  }



}
