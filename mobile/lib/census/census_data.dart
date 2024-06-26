import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/census/census_edit.dart';
import 'package:mobile/census/census_form.dart';
import 'package:mobile/model/household_table_model.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/screens/main_screen.dart';
import 'package:mobile/widgets/census_header_widget.dart';
import 'package:flutter/foundation.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}

class CensusData extends StatefulWidget {
  final User user;
  const CensusData({super.key, required this.user});

  @override
  State<CensusData> createState() => _CensusDataState();
}

class _CensusDataState extends State<CensusData> {
  List<HouseholdTableModel> households = [];
  List<HouseholdTableModel> filteredHouseholds = [];
  late final User user;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchHouseholds();
  }

  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://127.0.0.1:90/BDRRM';
    } else {
      return 'http://10.0.2.2:90/BDRRM';
    }
  }

  Future<void> fetchHouseholds() async {
    try {
      final response =
          await http.get(Uri.parse('${getBaseUrl()}/households.php'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          households = jsonResponse
              .map((data) => HouseholdTableModel.fromJson(data))
              .toList();
          filteredHouseholds = households;
        });
      } else {
        throw Exception('Failed to load households');
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteHousehold(HouseholdTableModel household) async {
    try {
      final response = await http.post(
        Uri.parse('${getBaseUrl()}/delete_household.php'),
        body: json.encode({'id': household.id}),
      );
      if (response.statusCode == 200) {
        setState(() {
          households.remove(household);
          filteredHouseholds.remove(household);
        });
      } else {
        throw Exception('Failed to delete household');
      }
    } catch (e) {
      // Handle error
    }
  }

  void filterHouseholds(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredHouseholds = households;
      } else {
        filteredHouseholds = households
            .where((household) => household.members
                .firstWhere((member) => member.hhMemberType == 'Head')
                .name
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
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

  Widget buildHeaderRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          Expanded(child: paddedCell('Name', isHeader: true)),
          if (!Responsive.isMobile(context)) ...[
            Expanded(child: paddedCell('Address', isHeader: true)),
            Expanded(child: paddedCell('Age', isHeader: true)),
            Expanded(child: paddedCell('Occupation', isHeader: true)),
            Expanded(child: paddedCell('Number', isHeader: true)),
            Expanded(child: paddedCell('Civil Status', isHeader: true)),
            Expanded(child: paddedCell('Date of Birth', isHeader: true)),
            Expanded(child: paddedCell('Religion', isHeader: true)),
            Expanded(child: paddedCell('Special Group', isHeader: true)),
            Expanded(child: paddedCell('Member Type', isHeader: true)),
          ],
          Expanded(child: paddedCell('Actions', isHeader: true)),
        ],
      ),
    );
  }

  Widget buildRow(BuildContext context, HouseholdTableModel household) {
    final headMember =
        household.members.firstWhere((member) => member.hhMemberType == 'Head');
    return ExpansionTile(
      title: Responsive.isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                paddedCell(headMember.name),
                paddedCell('${headMember.lot}, ${headMember.zone}'),
              ],
            )
          : Table(
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
                10: FixedColumnWidth(29.0), // for IconButton width
                11: FixedColumnWidth(29.0), // for IconButton width
              },
              children: [
                TableRow(
                  children: [
                    TableCell(child: paddedCell(headMember.name)),
                    TableCell(
                        child: paddedCell(
                            '${headMember.lot}, ${headMember.zone}')),
                    TableCell(child: paddedCell(headMember.age.toString())),
                    TableCell(child: paddedCell(headMember.occupation)),
                    TableCell(child: paddedCell(headMember.number)),
                    TableCell(child: paddedCell(headMember.civilStatus)),
                    TableCell(child: paddedCell(headMember.dateOfBirth)),
                    TableCell(child: paddedCell(headMember.religion)),
                    TableCell(child: paddedCell(headMember.specialGroup)),
                    TableCell(child: paddedCell(headMember.hhMemberType)),
                    TableCell(
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CensusEditForm(
                                household: household,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    TableCell(
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await deleteHousehold(household);
                        },
                      ),
                    ),
                  ],
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
                      TableCell(child: paddedCell('${headMember.lot}, ${headMember.zone}')),
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
                  Expanded(
                      child: paddedCell(
                          "Source of Water: ${household.waterSource}")),
                  Expanded(
                      child: paddedCell(
                          "Garbage Disposal: ${household.garbageDisposal}")),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: paddedCell(
                          "Status of House: ${household.houseStatus}")),
                  Expanded(
                      child: paddedCell(
                          "Toilet Facility: ${household.toiletFacility}")),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: paddedCell(
                          "Housing Materials: ${household.housingMaterial}")),
                  Expanded(
                      child: paddedCell(
                          "Communication: ${household.communication}")),
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
                  Expanded(
                      child: paddedCell(
                          "HH with Electricity: ${household.hhWithElectricity}")),
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
              MaterialPageRoute(
                  builder: (context) => MainScreen(user: widget.user)),
            );
          },
        ),
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Container(
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
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CensusHeaderWidget(headerText: "Census Data List"),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                  child: Text(
                    "*All user data in this application is strictly confidential, including usernames, personal information, and activity. We implement strong security measures and comply with the Philippine Data Privacy Act of 2012 (Republic Act 10173) to safeguard your privacy. THE FOLLOWING DATA MUST STRICTLY BE CONFIDENTIAL.*",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: TextField(
                          onChanged: filterHouseholds,
                          decoration: const InputDecoration(
                            labelText: 'Search by Head Name',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: TextButton.icon(
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
                            MaterialPageRoute(
                                builder: (context) =>
                                    CensusForm(user: widget.user)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 2),
                buildHeaderRow(context),
                const Divider(thickness: 2),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: filteredHouseholds.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        buildRow(context, filteredHouseholds[index]),
                        const Divider(thickness: 1),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
