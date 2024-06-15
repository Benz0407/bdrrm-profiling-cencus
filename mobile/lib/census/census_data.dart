import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/census/census_edit.dart';
import 'package:mobile/census/census_form.dart';
import 'package:mobile/model/household_table_model.dart';
import 'package:mobile/screens/main_screen.dart';
import 'package:mobile/widgets/census_header_widget.dart';

class CensusData extends StatefulWidget {
  const CensusData({super.key});

  @override
  State<CensusData> createState() => _CensusDataState();
}

class _CensusDataState extends State<CensusData> {
  List<HouseholdTableModel> households = [];

  @override
  void initState() {
    super.initState();
    fetchHouseholds();
  }

  Future<void> fetchHouseholds() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:90/BDRRM/households.php'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          households = jsonResponse.map((data) => HouseholdTableModel.fromJson(data)).toList();
        });
      } else {
        print('Failed to load households. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load households');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteHousehold(HouseholdTableModel household) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:90/BDRRM/delete_household.php'),
        body: json.encode({'id': household.id}),
      );
      if (response.statusCode == 200) {
        setState(() {
          households.remove(household);
        });
      } else {
        print('Failed to delete household. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete household');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget paddedCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 14 : 12,
        ),
      ),
    );
  }

  Widget buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          Expanded(child: paddedCell('Name', isHeader: true)),
          Expanded(child: paddedCell('Address', isHeader: true)),
          Expanded(child: paddedCell('Age', isHeader: true)),
          Expanded(child: paddedCell('Occupation', isHeader: true)),
          Expanded(child: paddedCell('Number', isHeader: true)),
          Expanded(child: paddedCell('Civil Status', isHeader: true)),
          Expanded(child: paddedCell('Date of Birth', isHeader: true)),
          Expanded(child: paddedCell('Religion', isHeader: true)),
          Expanded(child: paddedCell('Special Group', isHeader: true)),
          Expanded(child: paddedCell('HH Member Type', isHeader: true)),
          Expanded(child: paddedCell('Actions', isHeader: true)),
        ],
      ),
    );
  }

  Widget buildRow(HouseholdTableModel household) {
    final headMember = household.members.firstWhere((member) => member.hhMemberType == 'Head');
    print('Building row for household: ${household.waterSource}');
    return ExpansionTile(
      title: Row(
        children: [
          Expanded(child: paddedCell(headMember.name)),
          Expanded(child: paddedCell(household.address)),
          Expanded(child: paddedCell(headMember.age.toString())),
          Expanded(child: paddedCell(headMember.occupation)),
          Expanded(child: paddedCell(headMember.number)),
          Expanded(child: paddedCell(headMember.civilStatus)),
          Expanded(child: paddedCell(headMember.dateOfBirth)),
          Expanded(child: paddedCell(headMember.religion)),
          Expanded(child: paddedCell(headMember.specialGroup)),
          Expanded(child: paddedCell(headMember.hhMemberType)),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CensusEditForm(
                    household: household,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await deleteHousehold(household);
            },
          ),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                  5: FlexColumnWidth(),
                  6: FlexColumnWidth(),
                  7: FlexColumnWidth(),
                  8: FlexColumnWidth(),
                  9: FlexColumnWidth(),
                  10: FlexColumnWidth(),
                },
                children: household.members
                    .where((member) => member.hhMemberType == 'Member')
                    .map((member) {
                  return TableRow(
                    children: [
                      TableCell(child: paddedCell(member.name)),
                      TableCell(child: paddedCell(member.address)),
                      TableCell(child: paddedCell(member.age.toString())),
                      TableCell(child: paddedCell(member.occupation)),
                      TableCell(child: paddedCell(member.number)),
                      TableCell(child: paddedCell(member.civilStatus)),
                      TableCell(child: paddedCell(member.dateOfBirth)),
                      TableCell(child: paddedCell(member.religion)),
                      TableCell(child: paddedCell(member.specialGroup)),
                      TableCell(child: paddedCell(member.hhMemberType)),
                      TableCell(child: paddedCell('')),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: paddedCell("Source of Water: ${household.waterSource}")),
                  Expanded(child: paddedCell("Garbage Disposal: ${household.garbageDisposal}")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: paddedCell("Status of House: ${household.houseStatus}")),
                  Expanded(child: paddedCell("Toilet Facility: ${household.toiletFacility}")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: paddedCell("Housing Materials: ${household.housingMaterial}")),
                  Expanded(child: paddedCell("Communication: ${household.communication}")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: paddedCell("HH with: ${household.hhWith}")),
                  Expanded(child: paddedCell("Income: ${household.income}")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: paddedCell("HH with Electricity: ${household.hhWithElectricity}")),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CensusHeaderWidget(headerText: "Census Data List"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
              child: Text(
                "*All user data in this application is strictly confidential, including usernames, personal information, and activity. We implement strong security measures and comply with the Philippine Data Privacy Act of 2012 (Republic Act 10173) to safeguard your privacy. THE FOLLOWING DATA MUST STRICTLY BE CONFIDENTIAL.*",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.note_add_outlined,
                    color: Colors.blue,
                    size: 35,
                  ),
                  label: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CensusForm()),
                    );
                  },
                ),
              ],
            ),
            const Divider(thickness: 2),
            buildHeaderRow(),
            const Divider(thickness: 2),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: households.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      buildRow(households[index]),
                      const Divider(thickness: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
