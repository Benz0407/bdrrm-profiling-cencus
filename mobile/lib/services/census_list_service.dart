// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class CensusListService {

//   Future<void> fetchHouseholds() async {
//   try {
//     //change to 10.0.2.2 if emulator
//     final response = await http.get(Uri.parse('http://127.0.0.1:90/BDRRM/households.php'));
//     if (response.statusCode == 200) {
//       setState(() {
//         households = json.decode(response.body);
//       });
//     } else {
//       print('Failed to load households. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       throw Exception('Failed to load households');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
// }