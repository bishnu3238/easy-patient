import 'dart:developer';
import 'package:easy_patient/classes/util/customSnackBar.dart';
import 'package:easy_patient/screens/authentication/signup_page.dart';
import 'package:easy_patient/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../classes/patient/patient_master.dart';
import '../../classes/patient/patient_services/patient_auth.dart';
import '../../customs/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PatientAuth auth = PatientAuth();
  final loginFormValidation = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSubmitLogin() async {
    if (!loginFormValidation.currentState!.validate()) {
      CustomSnackBar.showSnackBar(
          "Enter valid credential", Colors.redAccent.shade700, context);
      return;
    }
    try {
      await auth
          .loginPatient(_phoneController.text, _passwordController.text)
          .then((value) {
        Provider.of<PatientMaster>(context, listen: false).patient = value;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PatientHomePage()));
      });
    } catch (e) {
      log("$e");

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed !'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    CustomSnackBar.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eazy Patient',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade600,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey.shade500, Colors.blueGrey.shade900],
            ),
          ),
          child: Center(
            child: Form(
              key: loginFormValidation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.mobile,
                              color: Colors.blueGrey.shade900, size: 20),
                        ),
                        hintText: 'Phone No',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) => value!.length < 10
                          ? "Enter your valid 10 digit Phone No *"
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.userLock,
                              color: Colors.blueGrey.shade900, size: 20),
                        ),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 8 ? "Enter correct password *" : null,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: LoadingButton(
                      text: 'Log In',
                      onPressed: () => _onSubmitLogin(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  InkWell(
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => SignupPage())),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("New User ? ",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                          Text(
                            "Sign Up",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
