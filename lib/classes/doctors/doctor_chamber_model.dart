import 'dart:convert';

class DoctorChamberModel {
  final String id;
  final String doctor_id;
  final String chamber_name;
  final String city;
  final String state;
  final String address;
  final String pincode;
  final double fee;
  final String image;
  final List<ChamberTimings> timing;
  final DateTime date;

  const DoctorChamberModel({
    required this.id,
    required this.doctor_id,
    required this.chamber_name,
    required this.city,
    required this.state,
    required this.address,
    required this.pincode,
    required this.fee,
    required this.image,
    required this.timing,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctor_id': doctor_id,
      'chamber_name': chamber_name,
      'city': city,
      'state': state,
      'address': address,
      'pincode': pincode,
      'fee': fee,
      'image': image,
      'date': date,
    };
  }

  factory DoctorChamberModel.fromMap(
    Map<String, dynamic> map,
    List<ChamberTimings> docChamberTiming,
  ) {
    List<ChamberTimings> timings = docChamberTiming
        .where((element) => element.chamber_id == "${map["id"]}")
        .toList();

    return DoctorChamberModel(
      id: map['id'] as String,
      doctor_id: map['doctor_id'] as String,
      chamber_name: map['chamber_name'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      address: map['address'] as String,
      pincode: map['pincode'] as String,
      fee: map['fee'] as double,
      image: map['image'] as String,
      date: map['date'] as DateTime,
      timing: timings,
    );
  }
}

class ChamberTimings {
  final String id;
  final String chamber_id;
  final Duration from_time;
  final Duration to_time;
  final List days;
  final String status;
  final DateTime date;

  const ChamberTimings({
    required this.id,
    required this.chamber_id,
    required this.from_time,
    required this.to_time,
    required this.days,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chamber_id': chamber_id,
      'from_time': from_time,
      'to_time': to_time,
      'days': jsonEncode(days),
      'status': status,
      'date': date,
    };
  }

  factory ChamberTimings.fromMap(Map<String, dynamic> map) {
    return ChamberTimings(
      id: map['id'] as String,
      chamber_id: map['chamber_id'] as String,
      from_time: parseTime(map['from_time']),
      to_time: parseTime(map['to_time']),
      days: jsonDecode(map['days']).map((e) => e).toList(),
      status: map['status'] as String,
      date: map['date'] as DateTime,
    );
  }
}

Duration parseTime(String input) {
  final parts = input.split(':');

  if (parts.length != 3) throw const FormatException('Invalid time format');

  int days;
  int hours;
  int minutes;
  int seconds;
  int milliseconds;
  int microseconds;

  {
    final p = parts[2].split('.');

    if (p.length != 2) throw const FormatException('Invalid time format');

    final p2 = int.parse(p[1].padRight(6, '0'));
    microseconds = p2 % 1000;
    milliseconds = p2 ~/ 1000;

    seconds = int.parse(p[0]);
  }

  minutes = int.parse(parts[1]);

  {
    int p = int.parse(parts[0]);
    hours = p % 24;
    days = p ~/ 24;
  }

  return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds);
}
