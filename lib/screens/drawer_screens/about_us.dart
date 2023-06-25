import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors.dart';
import '../../shared/typography.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  Widget text(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp
            )),
      ),
    );
  }

  Widget docPic(){
    return Container(
      width: 80.h,
      height: 80.h,
      decoration: BoxDecoration(
        border:
        Border.all(width: 1.7, color: buttonColor),
        shape: BoxShape.circle,
        image: const DecorationImage(
          image: AssetImage('assets/doc.png'),
          fit: BoxFit.cover
        ),

      ),
    );
  }

  Widget devPic1(){
    return Container(
      width: 80.h,
      height: 80.h,
      decoration: BoxDecoration(
          border:
          Border.all(width: 1.7, color: buttonColor),
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: AssetImage('assets/profile.png'),
              fit: BoxFit.cover
          )
      ),
    );
  }
  Widget devPic2(){
    return Container(
      width: 80.h,
      height: 80.h,
      decoration: BoxDecoration(
          border:
          Border.all(width: 1.7, color: buttonColor),
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: AssetImage('assets/profile.png'),
              fit: BoxFit.cover
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'About - Us',
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
              text('Authentic Physiotherapy Clinic "Home Care Services " is an exclusive service provided by highly trained and skilled Physiotherapist of Authentic group. We are into this field since the year 2008 . We assure you of the quality physio care.'),
              text('Welcome to our mobile application, designed to make booking medical appointments easy and convenient. Our team consists of a skilled and dedicated group of professionals who have combined their expertise to create this revolutionary app.'),
              const Divider(),
              text('Meet Our Doctor:'),
              docPic(),
              text("Dr Ujwal Bhattacharya.BPT, MPT ( Sports) PhD in Physiotherapy.\nSenior Physiotherapy Consultant.\nWorking Experience: 15 years both as Academician and Clinician .\nFellowship in Osteopathic Manual Therapy ( Australia ) .\nAccredited Teacher under Indian School of Biomechanical Correction . \nCertified Manual Therapist from MTFI , FIMT. \nCertified Dry needling and Cupping  Therapist.\nCertified FDM practitioner ( Germany).\nCertified DNS practitioner ( under Prague School).\nConducted Workshops on Osteopathic Manual Therapy , Sports Physiotherapy and Cupping \nInterests : Research , Clinical Trails, Rehabilitation."),
              const Divider(),
              text('Meet Our App Developers:'),
              devPic1(),
              text("Meet Animesh and Rishi, two hard-working and dedicated college students who are passionate about app development. With their combined knowledge and expertise, they have developed several innovative and user-friendly apps that have gained popularity among their peers and the wider community. Despite their busy academic schedules, Animesh and Rishi have been relentless in their pursuit of excellence, spending countless hours coding and debugging their apps to ensure optimal performance. Their commitment to their craft and determination to succeed has earned them a reputation as rising stars in the app development industry."),
              const Divider(),
              text('At our core, we believe that everyone deserves easy access to quality healthcare. With our app, patients can book appointments with just a few clicks, saving time and minimizing stress. Our goal is to create a platform that connects patients with the best medical providers and facilities, so they can receive the care they need when they need it.'),
              text('Thank you for choosing our mobile application. We hope it helps you take charge of your health and wellness.'),
          ],
          ),
        ),
      ),
    );
  }
}


