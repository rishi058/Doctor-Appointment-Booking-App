import 'package:clinic_app/models/staff_model.dart';
import 'package:clinic_app/services/authenticaton.dart';
import 'package:flutter/cupertino.dart';

class StaffProvider with ChangeNotifier {
  StaffModel? _staffModel;
  StaffModel get getStaff => _staffModel!;

  Future<void> refreshStaff() async {
    StaffModel patientModel = await Authentication().getStaffDetails();
    _staffModel = patientModel;
    notifyListeners();
  }
}
