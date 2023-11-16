import 'package:clinic_app/models/feedback_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../shared/typography.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isLoading = false;
  List<FeedBackModel> allFeedbacks = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allFeedbacks = Provider.of<List<FeedBackModel>>(context);
    Future.delayed(const Duration(seconds: 1), (() {
      setState(() {
        isLoading = false;
      });
    }));
    if (kDebugMode) {
      print(allFeedbacks);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Feedback Page',
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
      body: ListView.builder(
          itemCount: allFeedbacks.length,
          itemBuilder: (context, i) {
            return feedbackBox(
              allFeedbacks[i].dateOfFeedback,
              allFeedbacks[i].patientName,
              allFeedbacks[i].patientPhone,
              allFeedbacks[i].staffName,
              allFeedbacks[i].staffPhone,
              allFeedbacks[i].feedBack,
            );
          }),
    );
  }
}

Widget feedbackBox(
    String date,
    String patientName,
    String patientNo,
    String doctorName,
    String doctorNo,
    String feedback) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.w),
      color: Colors.white,
    ),
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(10.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: theme(
            sz: 18,
            wt: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            Text(
              'Patient Name  :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              patientName,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Patient No :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              patientNo,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            Text(
              'Physiotherapist Name :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              doctorName,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Text(
              'Physiotherapist No :  ',
              style: theme(sz: 15, wt: FontWeight.w500, clr: Colors.blueGrey),
            ),
            Text(
              doctorNo,
              style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          'Feedback : ',
          style: theme(sz: 15, wt: FontWeight.w600, clr: Colors.black54),
        ),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
              text: feedback,
            style: theme(sz: 14, wt: FontWeight.w500, clr: Colors.blueGrey),
          ),
        ),
      ],
    ),
  );
}