import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/household_head_model.dart';
import 'package:mobile/model/household_model.dart';
import 'package:mobile/model/household_member_model.dart';
import 'package:mobile/model/household_table_model.dart';

class FormService {
  static const String baseUrl = 'http://127.0.0.1:90/BDRRM';

  static Future<int> saveAndGetHousehold(Household household) async {
    final url = Uri.parse('$baseUrl/save_household.php');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(household.toJson()),
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('id')) {
          print(jsonResponse['id']);
          return jsonResponse['id'];
        } else {
          throw Exception('Server response does not contain id field');
        }
      } catch (e) {
        print('saveAndGEt Error decoding JSON: $e');
        throw Exception('Failed to parse server response');
      }
    } else {
      print('Failed to save household: ${response.statusCode}');
      throw Exception('Failed to save household');
    }
  }

  static Future<bool> saveHouseholdHead(HouseholdHead householdHead) async {
    final url = Uri.parse('$baseUrl/save_household_head.php');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(householdHead.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Print the response body for debugging
      print('Response body for SERVICE HEAD: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('Error saving household: $e');
      return false;
    }
  }

  static Future<bool> saveHouseholdMember(List<HouseholdMember> members) async {
    final url = Uri.parse('$baseUrl/save_household_member.php');
    try {
      // Convert each member to JSON and send as a batch request
      final List<Map<String, dynamic>> membersJson =
          members.map((member) => member.toJson()).toList();
      final response = await http.post(
        url,
        body: jsonEncode({'rows': membersJson}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('Response body for saveHouseholdMember: ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error saving household members: $e');
      return false;
    }
  }

  // Update household
  static Future<bool> updateHousehold(Household household, int? id) async {
    final url = Uri.parse('$baseUrl/update_household.php');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(household.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Print the response body for debugging
      print('Response body for updateHousehold: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating household: $e');
      return false;
    }
  }

  // Update household head
  static Future<bool> updateHouseholdHead(HouseholdHead householdHead) async {
    final url = Uri.parse('$baseUrl/update_household_head.php');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(householdHead.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Print the response body for debugging
      print('Response body for updateHouseholdHead: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating household head: $e');
      return false;
    }
  }

  // Update household members
  static Future<bool> updateHouseholdMembers(List<HouseholdMember> members) async {
    final url = Uri.parse('$baseUrl/update_household_member.php');
    try {
      // Convert each member to JSON and send as a batch request
      final List<Map<String, dynamic>> membersJson =
          members.map((member) => member.toJson()).toList();
      final response = await http.post(
        url,
        body: jsonEncode({'rows': membersJson}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('Response body for updateHouseholdMembers: ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating household members: $e');
      return false;
    }
  }
  
static Future<bool> deleteHouseholdMembers(List<int?> memberIds) async {
  final url = Uri.parse('$baseUrl/remove_household_members.php');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'memberIds': memberIds}),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody['success'];
  } else {
    return false;
  }
}
}
