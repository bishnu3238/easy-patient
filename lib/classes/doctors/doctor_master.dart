import "dart:developer";

import "package:easy_patient/classes/doctors/doctor_chamber_model.dart";
import "package:easy_patient/classes/doctors/doctor_model.dart";
import "package:easy_patient/classes/location/location_service.dart";
import "package:flutter/foundation.dart";
import "package:provider/provider.dart";

class DoctorMaster with ChangeNotifier {
  List<Doctor> _doctor = List.generate(
    16,
    (index) => Doctor(
      id: '$index',
      doc_id: '1$index',
      join_date: DateTime.now(),
      title: 'Dr.',
      doctor_name: 'doctor_name$index',
      image: 'image$index',
      department: 'department$index',
      mobile: '923166546$index',
      password: '123456$index',
      gender: 'Male',
      dob: DateTime.now(),
      address: 'address$index',
      email: 'email$index',
      specialist: index.isEven ? '$index' : "0",
      qulifica: 'qulifica$index',
      experi: 'experi$index',
      regn_no: 'regn_no$index',
      state: 'state$index',
      city: index.isOdd ? "Kolkata" : '$index',
      pincode: '70010${index + 5}',
      about_doctor: 'about_doctor$index',
      bank_name: 'bank_name$index',
      account_no: 'account_no$index',
      ifsc_code: 'ifsc_code$index',
      branch_code: 'branch_code$index',
      status: '1',
      date: DateTime.now(),
    ),
  );
  List<DoctorChamberModel> _doctorsChamber = List.generate(
      16,
      (index) => DoctorChamberModel(
          id: "$index",
          doctor_id: "1$index",
          chamber_name: "chamber_name$index",
          city: "city$index",
          state: "state$index",
          address: "address",
          pincode: "70010$index",
          fee: index * 1000,
          image: "image",
          timing: List.generate(
              16,
              (i) => ChamberTimings(
                  id: "$i",
                  chamber_id: "$index",
                  from_time: Duration(hours: 8 + i, minutes: 30),
                  to_time: Duration(hours: 12 + i, minutes: 30),
                  days: [0, 4, 5],
                  status: "$i",
                  date: DateTime.now())),
          date: DateTime.now()));

  set doctorsChamber(List<DoctorChamberModel> value) {
    _doctorsChamber = value;
  }

  List<DoctorChamberModel> get doctorsChamber => _doctorsChamber;

  List<Doctor> get doctor => _doctor;

  set doctor(List<Doctor> value) {
    _doctor = value;
  }

  List<Doctor> getDoctorAccordingToSpecialist(String specialistId) {
    List<Doctor> doc = [];
    // var location = Provider.of<LocationService>(context, listen: false).place[0].
    for (int i = 0; i < _doctor.length; i++) {
      if (_doctor[i].specialist == specialistId) {
        doc.add(_doctor[i]);
      }
    }
    return doc;
  }

  List<DoctorChamberModel> getDoctorChambars(String doctor_id) {
    List<DoctorChamberModel> docChamber = [];
    log("doctor ID: $doctor_id");
    for (int i = 0; i < _doctorsChamber.length; i++) {
      if (_doctorsChamber[i].doctor_id == doctor_id) {
        docChamber.add(_doctorsChamber[i]);
      }
    }
    return docChamber;
  }
}
