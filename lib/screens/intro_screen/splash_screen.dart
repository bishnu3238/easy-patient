import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../classes/webRTC/socket_services.dart';
import '../../customs/others/statics.dart';
import '../authentication/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  // void initState() {
  //   super.initState();
  //   const String serverUrl = "https://videocalling-lnl9.onrender.com";
  //   const String patientCallingID = "9231520717";
  //
  //   Future.delayed(const Duration(milliseconds: 4000), () {
  //     final context = _scaffoldKey.currentContext;
  //     if (context != null) {
  //       Provider.of<SignallingService>(context, listen: false).init(
  //         socketUrl: serverUrl,
  //         patientID: patientCallingID,
  //       );
  //       Provider.of<SignallingService>(context, listen: false).socket!.on("newCall", (data) {
  //         Provider.of<SignallingService>(context, listen: false).incomingSDPOffer = data;
  //         log("incoming SDP Offer: ${Provider.of<SignallingService>(context).incomingSDPOffers}");
  //       });
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (ctx) => const LoginPage()),
  //       );
  //     }
  //   });
  // }
  ///
  void initState() {
    super.initState();
    // signalling server url
    const String serverUrl = "https://videocalling-lnl9.onrender.com";

    // generate callerID of local user
    const String patientCallingID = "9231520717";

    Future.delayed(const Duration(milliseconds: 4000), () {
      SignallingService.instance.init(
        socketUrl: serverUrl,
        patientID: patientCallingID,
      );
      // listen for incoming video call
      SignallingService.instance.socket!.on("newCall", (data) {
        print("data: $data");
        // if (!mounted) {
        // set SDP Offer of incoming call
        // Provider.of<SignallingService>(context, listen: false).incomingSDPOffer = data;
        // log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ${Provider.of<SignallingService>(context, listen: false).incomingSDPOffer.toString()}");
        // }
      });

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
