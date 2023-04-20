import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api/api.dart';
import '../patient_model.dart';

class PatientAuth {
  Future<Patient> loginPatient(String username, String password) async {
    String api = Api.loginApi;
    final response = await http.post(
      Uri.parse(api),
      body: jsonEncode(
        {
          'username': username,
          'password': password,
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        return responseData['patient'];
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
