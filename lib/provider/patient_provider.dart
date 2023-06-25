import 'package:clinic/models/patient_model.dart';
import 'package:clinic/services/authenticaton.dart';
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
