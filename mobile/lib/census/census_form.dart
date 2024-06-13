import 'package:flutter/material.dart';
import 'package:mobile/census/census_data.dart';
import 'package:mobile/widgets/head_form_widget.dart';
import 'package:mobile/widgets/census_header_widget.dart';
import 'package:mobile/widgets/member_form_widget.dart';

class CensusForm extends StatefulWidget {
  const CensusForm({super.key});

  @override
  _CensusFormState createState() => _CensusFormState();
}

class _CensusFormState extends State<CensusForm> {
  // List<Widget> householdMembers = [];
  List<int> householdMemberIndices = [];

  @override
  void initState() {
    super.initState();
    // Initialize with one household member form
    addHouseholdMember();
  }

  // void addHouseholdMember() {
  //   setState(() {
  //     householdMembers.add(
  //       HouseholdMemberForm(
  //         key: UniqueKey(),
  //         index: householdMembers.length + 1,
  //         onRemove: () => removeHouseholdMember(householdMembers.length + 1),
  //       ),
  //     );
  //   });
  // }

  void addHouseholdMember() {
    setState(() {
      householdMemberIndices.add(householdMemberIndices.length + 1);
    });
  }

  void removeHouseholdMember(int index) {
    setState(() {
      householdMemberIndices.remove(index);
      // Re-index household members after removal
      householdMemberIndices = householdMemberIndices
          .asMap()
          .map((index, value) => MapEntry(index, index + 1))
          .values
          .toList();
    });
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
              MaterialPageRoute(builder: (context) => const CensusData()),
            );
          },
        ),
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent, // SurfaceTintColor removed
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
          children: [
            const CensusHeaderWidget(headerText: "Census Form"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "*All user data in this application is strictly confidential, including usernames, personal information, and activity. We implement strong security measures and comply with the Philippine Data Privacy Act of 2012 (Republic Act 10173) to safeguard your privacy. THE FOLLOWING DATA MUST STRICTLY BE CONFIDENTIAL.*",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
            // FORM HERE INSIDE A BOX WITH WHITE background
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ListView(
                  children: [
                    // HOUSEHOLD HEAD FORM
                    const Text(
                      'Household Head',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const HouseholdHeadForm(),

                    // HOUSEHOLD MEMBER FORM
                    Column(
                      children: householdMemberIndices.map((index) {
                        return HouseholdMemberForm(
                          key: UniqueKey(),
                          index: index,
                          onRemove: () => removeHouseholdMember(index),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: addHouseholdMember,
                      child: const Text('Add Household Member'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Household Amenities and Characteristics',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // const HouseholdAmenitiesForm(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Save action
                          },
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Cancel action
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
