import 'package:easy_patient/classes/patient/patient_master.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Patient {
  final int id;
  final int? patientId;
  final String? name;
  final String? gender;
  final int? ageYears;
  final int? ageMonths;
  final int? ageDays;
  final String? mobile;
  final String? email;
  final String? fullAddress;
  final String? pinCode;
  final int? referId;
  final int? status;
  final DateTime? registrationDate;

  Patient({
    required this.id,
    this.patientId,
    this.name,
    this.gender,
    this.ageYears,
    this.ageMonths,
    this.ageDays,
    this.mobile,
    this.email,
    this.fullAddress,
    this.pinCode,
    this.referId,
    this.status,
    this.registrationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'name': name,
      'gender': gender,
      'ageYears': ageYears,
      'ageMonths': ageMonths,
      'ageDays': ageDays,
      'mobile': mobile,
      'email': email,
      'fullAddress': fullAddress,
      'pinCode': pinCode,
      'referId': referId,
      'status': status,
      'registrationDate': registrationDate,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as int,
      patientId: map['patientId'] as int,
      name: map['name'] as String,
      gender: map['gender'] as String,
      ageYears: map['ageYears'] as int,
      ageMonths: map['ageMonths'] as int,
      ageDays: map['ageDays'] as int,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      fullAddress: map['fullAddress'] as String,
      pinCode: map['pinCode'] as String,
      referId: map['referId'] as int,
      status: map['status'] as int,
      registrationDate: map['registrationDate'] as DateTime,
    );
  }





}
