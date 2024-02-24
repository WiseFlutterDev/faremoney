import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> signUpUser(String id, String fullName, String email, String role, String dob, String passkey, int alreadyAuthorize, String password, String phone) async {
  // Encode parameters to ensure they're properly formatted in the URL
  final encodedFullName = Uri.encodeComponent(fullName);
  final encodedEmail = Uri.encodeComponent(email);
  final encodedDob = Uri.encodeComponent(dob);
  final encodedPassword = Uri.encodeComponent(password);

  // Construct the URL with parameters
  final url = Uri.parse('https://faremoney.000webhostapp.com/faremoney/signup.php?id=$id&full_name=$encodedFullName&email=$encodedEmail&role=$role&dob=$encodedDob&passkey=$passkey&AlreadyAuthorize=$alreadyAuthorize&password=$encodedPassword&phone=$phone');

  try {
    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response body as JSON
      final jsonResponse = json.decode(response.body);

      // Check if the status is success
      if (jsonResponse['status'] == 'success') {
        // Print the response body to the screen
        print(response.body);

        // Save the passkey
        final passkey = jsonResponse['passkey'];

        // Return the passkey
        return passkey;
      } else {
        // Print error message if status is not success
        print('Error: ${jsonResponse['error_message']}');

        // Return null since sign up failed
        return null;
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
