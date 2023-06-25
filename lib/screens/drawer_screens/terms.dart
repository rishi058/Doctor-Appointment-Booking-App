import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  Widget text(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: RichText(
        text: TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Terms and Conditions',
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              text('1. Introduction: These terms and conditions govern your use of our appointment booking service Authentic Physiotherapy. By using the Service, you accept these terms in full. If you disagree with these terms and conditions or any part of these terms and conditions, you must not use the Service.'),
              text('2. Booking Appointments: The Service allows you to book appointments with service providers through our website. You are responsible for ensuring that all information you provide is accurate, complete and up-to-date'),
              text('3. Payment: Payment for appointments must be made at the time of booking through the Service. We accept payment via credit/debit card or other payment methods as specified on our website.'),
              text('4. Cancellations and Rescheduling: If you need to cancel or reschedule an appointment, you must do so at least 24 hours prior to the appointment time. If you cancel or reschedule less than 24 hours before the appointment time, you may be charged a fee.'),
              text('5. Refund Policy: If you are not satisfied with the Service or if there has been an error with your appointment booking, please contact us. We will make every effort to resolve the issue to your satisfaction and, if necessary, issue a refund.'),
              text('6. Limitation of Liability: The Service is provided "as is" and we make no representations or warranties of any kind, express or implied, as to the operation of the Service or the information, content, materials or products included on this website.'),
              text('7. Changes to Terms of Service: We reserve the right to modify these terms and conditions at any time. Your continued use of the Service following any changes to these terms and conditions constitutes your acceptance of the new terms.'),
              text('8. Governing Law: These terms and conditions are governed by and construed in accordance with the laws of the jurisdiction in which theService is provided and you agree to submit to the exclusive jurisdiction of the courts of that jurisdiction'),
              text('By using the Service, you acknowledge that you have read and understand these terms of service and agree to be bound by them')
            ],
          ),
        ),
      ),
    );
  }
}


