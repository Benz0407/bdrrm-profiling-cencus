import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/household_member.dart';
import 'package:mobile/model/household_model.dart';

class ApiService {
  static const baseUrl = 'http://127.0.0.1:90/BDRRM/create_household.php';
  Future<void> addHousehold(Map<String, dynamic> householdData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'action': 'addHousehold',
          ...householdData,
        }),
      );

      if (response.statusCode == 201) {
        print('Household added successfully');
      } else {
        print('Failed to add household: ${response.body}');
      }
    } catch (e) {
      print('Error adding household: $e');
    }
  }

}