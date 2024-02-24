import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<bool?> loginUser(String email,  String password) async {
  // // Encode parameters to ensure they're properly formatted in the URL
  // final encodedFullName = Uri.encodeComponent(fullName);
  final encodedEmail =email;
  final storage = FlutterSecureStorage();

  // final encodedDob = Uri.encodeComponent(dob);
  final encodedPassword = password;

  // Construct the URL with parameters
  final url = Uri.parse('https://faremoney.000webhostapp.com/faremoney/login.php?email=$encodedEmail&password=$encodedPassword');

  try {
    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response body as JSON
      final jsonResponse = json.decode(response.body);

      // Check if the status is success
      if (jsonResponse['status'] == 'success') {
        print(response.body);
        await storage.write(key: 'token', value: jsonResponse['passkey'] );
        return true;

        // Save the passkey
        final passkey = jsonResponse['passkey'];

        // Return the passkey
        return passkey;
      } else {
        // Print error message if status is not success
       return false;

      }
    } else {
      // Print error message if request failed
      print('Error: Request failed with status ${response.statusCode}');

      // Return null since sign up failed
      return null;
    }
  } catch (e) {
    // Print error message if an exception occurred
    print('Error: $e');

    // Return null since sign up failed
    return null;
  }
}
