import 'package:easy_patient/classes/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/location/location_service.dart';
import '../../classes/util/customSnackBar.dart';
import '../../classes/webRTC/socket_services.dart';
import '../../customs/others/statics.dart';
import '../authentication/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    CustomSnackBar.initialize(context);
    Provider.of<LocationService>(context, listen: false).getCurrentLocation();

    // generate callerID of local user
    const String patientCallingID = "9231520717";

    Future.delayed(const Duration(milliseconds: 4000), () {
      SignallingService.instance.init(
          socketUrl: Api.serverUrl,
          patientID: patientCallingID,
          context: context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("$img/logo.jpg", width: 75),
              const SizedBox(height: 15),
              const Text("Easy Patient"),
            ],
          ),
        ),
      ),
    );
  }
}
