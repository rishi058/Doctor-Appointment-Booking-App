import 'package:clinic_app/models/patient_model.dart';
import 'package:clinic_app/services/authenticaton.dart';
import 'package:flutter/cupertino.dart';

class PatientProvider with ChangeNotifier {
  PatientModel? _patientModel;
  PatientModel get getPatient => _patientModel!;

  Future<void> refreshPatient() async {
    PatientModel patientModel = await Authentication().getUserDetails();
    _patientModel = patientModel;
    notifyListeners();
  }
}
