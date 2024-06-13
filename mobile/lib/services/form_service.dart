import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  
  static const String apiUrl = 'http://127.0.0.1:90/BDRRM/households.php';

  Future<void> submitForm(Map<String, String> formData) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(formData),
    );

    if (response.statusCode == 200) {
      // Handle successful submission
      print('Form submitted successfully');
    } else {
      // Handle error
      print('Form submission failed: ${response.body}');
    }
  }
}
