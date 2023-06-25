import 'package:clinic/models/staff_model.dart';
import 'package:clinic/services/authenticaton.dart';
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
