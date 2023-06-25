import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class RefundPolicy extends StatelessWidget {
  const RefundPolicy({Key? key}) : super(key: key);

  Widget text(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: RichText(
        text: TextSpan(
            text: value,
            style: TextStyle(color: Colors.black, fontSize: 14.sp)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Cancellation and Refund Policy',
          style: theme(sz: 17),
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
              text(
                  '1. Introduction: This cancellation and refund policy governs the cancellation and refund process for appointments booked through our booking appointment.'),
              text(
                  '2. Cancellation of Appointments: If you need to cancel an appointment,you must do so at least 24 hours prior to the appointment time. If you cancel less than 24 hours before the appointment time, you may be charged a fee.'),
              text(
                  '3. Processing Time for Refunds: Refunds will be processed within 7-10 business days of receipt of the refund request.'),
              text(
                  '4. Limitation of Liability: The App is provided "as is" and we make no representations or warranties of any kind, express or implied, as to the operation of the App or the information, content, materials or products included on this App.'),
              text(
                  '5. Changes to Policy: We reserve the right to modify this Policy at any time.Your continued use of the App following any changes to this Policy constitutes your acceptance of the new Policy.'),
              text(
                  '6. Contact Information: If you have any questions or concerns about thisPolicy or the cancellation and refund process, please contact us at rishi.helloworld@gmail.com.'),
              text(
                  'The Company is committed to providing excellent customer service and resolving any issues to your satisfaction. By using the App, you agree to be bound by this cancellation and refund policy'),
            ],
          ),
        ),
      ),
    );
  }
}
