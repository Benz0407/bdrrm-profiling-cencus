import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/model/user_model.dart';
import 'package:http/http.dart' as http;

 String getBaseUrl() {
    if (kIsWeb) {
      return 'http://127.0.0.1:90/BDRRM';
    } else {
      return 'http://10.0.2.2:90/BDRRM';
    }
  }
  
class RegisterService with ChangeNotifier {

  Future<void> registerUser(User user) async {
    try {
      
      final response = await http.post(
        Uri.parse("${getBaseUrl()}/register.php"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );
      // print("response.body ${response.body}");
      if (response.statusCode == 201) {
        // Successfully registered
        // print('User registered successfully');
      } else {
        // Handle error
        // print('Failed to register user: ${response.body}');
      }
    } catch (e) {
      // print("error register $e");
    }
  }
}