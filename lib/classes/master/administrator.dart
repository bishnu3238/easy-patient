import 'package:easy_patient/classes/doctors/doctor_chamber_model.dart';
import 'package:easy_patient/classes/master/specialist_master.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Administrator with ChangeNotifier {
  List<Specialist> _specialist = List.generate(
      16,
      (index) =>
          Specialist(id: index, special_name: "special$index", status: "1"));

  List<Specialist> get specialist => _specialist;

  set specialist(List<Specialist> value) {
    _specialist = value;
  }

  List<String> getTimeSlots(Duration fromTime, Duration toTime) {
    final List<String> timeSlots = [];
    print(525 % 10);
    print(525 + (10 - (525 % 10)));

    final int fromMinutes = (fromTime.inMinutes % 10 == 0)
        ? fromTime.inMinutes
        : fromTime.inMinutes + (10 - (fromTime.inMinutes % 10));
    var current = Duration(minutes: fromMinutes);

    while (current.inMinutes <= toTime.inMinutes) {
      final DateTime dateTime = DateTime.utc(2023, 1, 1, 0, current.inMinutes);
      final String timeSlot = DateFormat.jm().format(dateTime);
      timeSlots.add(timeSlot);
      current += const Duration(minutes: 10);
    }

    return timeSlots;
  }

  selectedDateAvailable(
      DateTime selectedDate, DoctorChamberModel doctorChamber) {
    bool hasSlot = false;
    for (int i = 0; i < doctorChamber.timing[0].days.length; i++) {
      debugPrint("index ${doctorChamber.timing[0].days.map((e) => e)}");
      if (selectedDate.weekday == doctorChamber.timing[0].days[i]) {
        hasSlot = true;
      } else {
        hasSlot = false;
      }
    }
    return hasSlot;
  }
}
