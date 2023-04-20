import 'dart:async';

import 'package:easy_patient/screens/authentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../customs/loading_button.dart';
import '../dashboard/home.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;
  int _resendTimer = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTimer == 0) {
        timer.cancel();
      } else {
        setState(() {
          _resendTimer--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phoneNO = "9231665466";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => SignupPage())),
            icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40.0),
              const Text(
                'Enter the OTP',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Please enter the OTP sent to\n+91 $phoneNO',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blueGrey[700],
                ),
              ),
              const SizedBox(height: 60),
              Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.red[800],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          } else if (value.length == null) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    // Expanded(
                    // child: TextField)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  const Text(
                    'Did\'t receive the OTP?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  _resendTimer == 0
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _resendTimer = 60;
                            });
                            startTimer();
                            // TODO: Handle resend OTP logic
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: 16.0,
                              // color: Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          ' $_resendTimer seconds',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                ],
              ),
              const SizedBox(height: 28),
              LoadingButton(
                color: Colors.blueGrey.shade900,
                text: 'Verify',
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const PatientHomePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
