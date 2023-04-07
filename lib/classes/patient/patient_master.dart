import 'package:easy_patient/classes/patient/patient_model.dart';
import 'package:flutter/foundation.dart';

class PatientMaster with ChangeNotifier {
  late Patient _patient;

  Patient get patient => _patient;

  set patient(Patient value) {
    _patient = value;
    notifyListeners();
  }
}
