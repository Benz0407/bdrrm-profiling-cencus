import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<void> saveDataToDatabase(Map<String, dynamic> data) async {
    const url =
        'http://127.0.0.1:90/BDRRM/create_household.php'; // Replace with your actual PHP file URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        // Data saved successfully
        print(responseData['message']);
      } else {
        // Error saving data
        print(responseData['message']);
      }
    } else {
      // HTTP request failed
      print('Failed to save data. Error code: ${response.statusCode}');
    }
  }
}
