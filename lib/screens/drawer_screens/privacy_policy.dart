import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
          'Privacy Policy',
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
              text('1. Introduction: This privacy policy governs the collection, use, storage and sharing of personal information by our company in connection with the use of our booking appointment.'),
              text('2. Collection of Personal Information: The Company may collect personal information such as name, email address, payment information, and demographic information when you use the App to book an appointment.'),
              text('3. Use of Personal Information: The Company may use your personal information to provide the services requested through the App, to improve the App, to communicate with you, to respond to your inquiries, and to comply with legal requirements'),
              text('4. Storage of Personal Information: The Company will store your personal information securely on our servers and will take appropriate technical and organizational measures to protect your personal information against unauthorized or unlawful access, use, alteration, or disclosure.'),
              text('5. Sharing of Personal Information: The Company will not share your personal information with third parties except as necessary to provide the services requested through the App, to comply with legal requirements, or with your consent.'),
              text('6. Access to Personal Information: You have the right to access, update, or delete your personal information held by the Company at any time.'),
              text('7. Data Retention: The Company will retain your personal information for as long as necessary to fulfill the purposes outlined in this Policy, unless a longer retention period is required or permitted by law.'),
              text('8. Changes to Privacy Policy: The Company may update this Policy from time to time and will notify you of any changes by posting the updatedPolicy on the App. Your continued use of the App following any changes to this Policy constitutes your acceptance of the updated Policy.'),
              text('9. Contact Information: If you have any questions or concerns about thisPolicy or the Company\'s collection, use, storage, or sharing of your personal information, please contact us at rishi.helloworld@gmail.com .'),
              text('10.The Company is committed to protecting your personal information and respecting your privacy. By using the App, you consent to the collection,use, storage, and sharing of your personal information as described in this Policy'),
            ],
          ),
        ),
      ),
    );
  }
}


