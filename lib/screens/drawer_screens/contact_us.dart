import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

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
          'Contact - Us',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              text('We are here to help and answer any questions you may have about our mobile application. Please feel free to contact us using the information below:'),
              text('Email:'),
              text('You can reach us at clinic9190@gmail.com. We will do our best to respond to your email within 24 hours.'),
              text('Phone:'),
              text('You can contact us by phone at +91 XXXXXXXXXX. Our support team is available from 9 am to 5 pm EST, Monday to Friday.'),
              text('Social Media:'),
              text('You can also reach us through our social media channels. Follow us on Facebook, Twitter, and Instagram to stay up-to-date with the latest news and updates.'),
              text('Feedback:'),
              text('We value your feedback and are always looking for ways to improve our app. If you have any suggestions or comments, please feel free to send us an email at clinic9190@gmail.com.'),
              text('Technical Support:'),
              text('If you are experiencing technical issues with our app, please email us at clinic9190@gmail.com. Our team will work quickly to address any technical issues you may be facing.'),
              text('We are committed to providing the best customer service possible and are always happy to hear from our users. Please do not hesitate to contact us if you have any questions, concerns, or comments about our app.'),
            ],
          ),
        ),
      ),
    );
  }
}


