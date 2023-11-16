// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/models/staff_model.dart';
import 'package:clinic_app/services/database.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../Widgets/payment_page_card.dart';
import '../../shared/typography.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:clinic_app/services/email_js.dart';

class TakeFeedbackPage extends StatefulWidget {
  const TakeFeedbackPage(
      {Key? key, required this.id, required this.appointmentId})
      : super(key: key);

  final String id;
  final String appointmentId;
  @override
  State<TakeFeedbackPage> createState() => _TakeFeedbackPageState();
}

class _TakeFeedbackPageState extends State<TakeFeedbackPage> {
  final feed = TextEditingController();
  bool isLoading = false;
  List<StaffModel> staff = [];
  double rating = 3.5;
  String userName = "", userPhone = "";

  @override
  void initState() {
    setData();
    isLoading = true;
    super.initState();
  }

  void setData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await Database().getUser(uid).then((value) {
      if(value!=null){
        setState(() {
          userName = value.patientName;
          userPhone = value.patientPhone;
        });
      }
    });
  }

  @override
  void dispose() {
    feed.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    staff = Provider.of<List<StaffModel>>(context)
        .where((element) => element.staffUid == widget.id)
        .toList();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    if (kDebugMode) {
      print(staff);
    }
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'FeedBack Page',
          style: theme(sz: 18),
        ),
      ),
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  idCard(
                    staff[0].staffName,
                    staff[0].staffPhone,
                    staff[0].staffRating,
                    staff[0].staffProfPic,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: Text(
                        'Rate Your Experience : ',
                        style: theme(sz: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rat) {
                      rating = rat;
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: Text(
                        'Write Your Feedback : ',
                        style: theme(sz: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 130.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 7.w),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: 'Enter Your Feedback',
                            border: InputBorder.none),
                        controller: feed,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          double staffRating = double.parse(staff[0].staffRating);
          staffRating = (staffRating + rating) / 2;
          staffRating = double.parse((staffRating).toStringAsFixed(1)) ;
          bool isSuccess = await Database().addFeedBack(
              staff[0].staffUid,
              staff[0].staffName,
              staff[0].staffPhone,
              userName,
              userPhone,
              feed.text.trim(),
              staffRating.toString(),
              FirebaseAuth.instance.currentUser!.uid,
              widget.appointmentId,
              context);
          if (isSuccess) {
            sendEmailAboutFeedback(feed.text, staff[0].email, staff[0].staffName, staff[0].staffPhone, userName, userPhone);
            feed.text = "";
            AwesomeDialog(
                    dialogType: DialogType.success,
                    borderSide: BorderSide(color: primaryColor, width: 2),
                    dismissOnTouchOutside: false,
                    dismissOnBackKeyPress: false,
                    animType: AnimType.leftSlide,
                    title: 'Thanks for your time',
                    context: context)
                .show();
            Future.delayed(
                const Duration(
                  seconds: 2,
                ), () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('patient-dashboard');
            });
          }
        },
        child: Container(
          height: 35.h,
          margin: EdgeInsets.only(right: 13.w, left: 13.w, bottom: 13.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            color: buttonColor,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Submit Feedback',
              style: theme(sz: 15, clr: Colors.white, sp: 2),
            ),
          ),
        ),
      ),
    );
  }
}
