import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://127.0.0.1:90/BDRRM';
    } else {
      return 'http://10.0.2.2:90/BDRRM';
    }
  }

class LoginService with ChangeNotifier {
  Future<bool> loginUser(User user) async {
    final url = Uri.parse("${getBaseUrl()}/login.php");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "userType": user.userType,
      "userName": user.userName,
      "password": user.password,
    });
    // Print the body for debugging
    // print("Request body: $body");

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == "success") {
          await _saveUserSession(data['id']);
          notifyListeners();
          return true;
        } else {
          // print("Login failed: ${data['message']}");
          return false;
        }
      } else {
        // print("loginProvider Server error: ${response.statusCode}");
        // print("Error message: ${response.body}");
        return false;
      }
    } catch (e) {
      // print("An error occurred: $e");
      return false;
    }
  }

  Future<void> _saveUserSession(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
  }

  Future<void> signOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('id');
  }
}
