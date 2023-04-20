import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService with ChangeNotifier {
  late Position _location;
  late bool _serviceEnabled;
  late LocationPermission _permission;
  List<PlaceMarks> _place = [];

  Position get location => _location;
  bool get serviceEnabled => _serviceEnabled;
  List<PlaceMarks> get place => _place;
  LocationPermission get permission => _permission;

  Future getCurrentLocation() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission != LocationPermission.whileInUse &&
          _permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $_permission).');
      }
    }
    _location = await Geolocator.getCurrentPosition();
    var data =
        await placemarkFromCoordinates(_location.latitude, _location.longitude);
    _place = placeMarksFromJson(data);

    log("${_location.latitude} ${place[0]}");
    notifyListeners();
  }

  Future getPermission() async {
    await Geolocator.openAppSettings();
    // await Geolocator.openLocationSettings();
    // await getCurrentLocation();
  }
}

List<PlaceMarks> placeMarksFromJson(List<Placemark> data) =>
    List<PlaceMarks>.from(data.map((x) => PlaceMarks.fromMap(x)));

class PlaceMarks {
  final String? name;

  final String? street;

  final String? isoCountryCode;

  final String? country;

  final String? postalCode;

  final String? administrativeArea;

  final String? subAdministrativeArea;

  final String? locality;

  final String? subLocality;

  final String? thoroughfare;

  final String? subThoroughfare;

  const PlaceMarks({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'street': street,
      'isoCountryCode': isoCountryCode,
      'country': country,
      'postalCode': postalCode,
      'administrativeArea': administrativeArea,
      'subAdministrativeArea': subAdministrativeArea,
      'locality': locality,
      'subLocality': subLocality,
      'thoroughfare': thoroughfare,
      'subThoroughfare': subThoroughfare,
    };
  }

  factory PlaceMarks.fromMap(Placemark map) {
    return PlaceMarks(
      name: map.name as String,
      street: map.street as String,
      isoCountryCode: map.isoCountryCode as String,
      country: map.isoCountryCode as String,
      postalCode: map.postalCode as String,
      administrativeArea: map.administrativeArea as String,
      subAdministrativeArea: map.subAdministrativeArea as String,
      locality: map.locality as String,
      subLocality: map.subLocality as String,
      thoroughfare: map.thoroughfare as String,
      subThoroughfare: map.subThoroughfare as String,
    );
  }
}
