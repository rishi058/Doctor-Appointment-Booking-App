import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future sendEmailAboutNewAppointment(String name, String phoneNo) async {
  String message = "A New Appointment has been requested by one of you fellow patient $name whose contact detail is $phoneNo ";
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = "service_fo8ls5c";
  const templateId = "template_otzc6be";
  const userId = "FiztVTCRNjbTTfUW1";
  const privateKey = "TyZEoLbnxYlG-nqRaWp12";
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      "service_id": serviceId,
      "template_id": templateId,
      "user_id": userId,
      "accessToken": privateKey,
      "template_params": {
        "name": "",
        "subject": "New Appointment",
        "message": message,
        "user_email": "rishiqwerty01@gmail.com",
      }
    }),
  );
  if (kDebugMode) {
    print('-----------------');
    print(response.statusCode);
    print(response.body);
  }
}

Future sendEmailAboutFeedback(String feedContent, String staffEmail, String staffName, String staffPhone, String userName, String userPhone) async {
  String message1 = "A New Feedback is added by one of your fellow patient.";
  String message2 = "Feedback : $feedContent \n  Patient : $userName($userPhone) \n Physio Assigned : $staffName($staffPhone)" ;

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = "service_fo8ls5c";
  const templateId = "template_otzc6be";
  const userId = "FiztVTCRNjbTTfUW1";
  const privateKey = "TyZEoLbnxYlG-nqRaWp12";
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      "service_id": serviceId,
      "template_id": templateId,
      "user_id": userId,
      "accessToken": privateKey,
      "template_params": {
        "name": message1,
        "subject": "New FeedBack",
        "message": message2,
        "user_email": staffEmail,
      }
    }),
  );
  if (kDebugMode) {
    print(response.body);
  }
}


Future sendEmailAboutAssignedTask(String physioName, String physioEmail) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = "service_fo8ls5c";
  const templateId = "template_moedfdl";
  const userId = "FiztVTCRNjbTTfUW1";
  const privateKey = "TyZEoLbnxYlG-nqRaWp12";
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      "service_id": serviceId,
      "template_id": templateId,
      "user_id": userId,
      "accessToken": privateKey,
      "template_params": {
        "name": physioName,
        "subject": "------",
        "message": "-----",
        "user_email": physioEmail,
      }
    }),
  );
  if (kDebugMode) {
    print(response.body);
  }
}