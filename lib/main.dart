import 'package:easy_patient/classes/location/location_service.dart';
import 'package:easy_patient/classes/master/administrator.dart';
import 'package:easy_patient/screens/intro_screen/splash_screen.dart';
import '../../customs/others/themes/dark_theme.dart';
import '../../customs/others/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes/doctors/doctor_master.dart';
import 'classes/patient/patient_master.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientMaster()),
        ChangeNotifierProvider(create: (context) => LocationService()),
        ChangeNotifierProvider(create: (context) => DoctorMaster()),
        ChangeNotifierProvider(create: (context) => Administrator()),
      ],
      child: MaterialApp(
        title: "Easy Patient",
        theme: LightTheme.light,
        darkTheme: DarkTheme.dark,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
