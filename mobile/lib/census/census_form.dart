import 'package:flutter/material.dart';
import 'package:mobile/census/census_data.dart';
import 'package:mobile/model/household_model.dart';
import 'package:mobile/model/household_member_model.dart';
import 'package:mobile/model/household_head_model.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/services/form_service.dart';
import 'package:mobile/widgets/amenities_characteristics_form_widget.dart';
import 'package:mobile/widgets/head_form_widget.dart';
import 'package:mobile/widgets/census_header_widget.dart';
import 'package:mobile/widgets/member_form_widget.dart';

class CensusForm extends StatefulWidget {
  final User user;
  const CensusForm({super.key, required this.user});

  @override
  State<CensusForm> createState() => _CensusFormState();
}

class _CensusFormState extends State<CensusForm> {
  HouseholdHead householdHead = HouseholdHead();
  Household householdHeadAmenities = Household();
  List<HouseholdMember> householdMembers = [];
  List<GlobalKey<HouseholdMemberFormState>> householdMemberFormKeys = [];

  final GlobalKey<HouseholdHeadFormState> householdHeadFormKey =
      GlobalKey<HouseholdHeadFormState>();
  final GlobalKey<HouseholdAmenitiesFormState> householdAmenitiesFormKey =
      GlobalKey<HouseholdAmenitiesFormState>();

  @override
  void initState() {
    super.initState();
    addHouseholdMember();
  }

  void addHouseholdMember() {
    setState(() {
      householdMembers.add(HouseholdMember());
      householdMemberFormKeys.add(GlobalKey<HouseholdMemberFormState>());

      householdHeadFormKey.currentState?.updateHead();
      householdAmenitiesFormKey.currentState?.updateAmenities();

      // the form will not reset
      for (var key in householdMemberFormKeys) {
        key.currentState?.updateMember();
      }
    });
  }

  void removeHouseholdMember(int index) {
    setState(() {
      householdMembers.removeAt(index);
      householdMemberFormKeys.removeAt(index);
    });
  }

  void updateHouseholdMember(int index, HouseholdMember member) {
    setState(() {
      householdMembers[index] = member;
    });
  }

  void updateHouseholdHead(HouseholdHead head) {
    setState(() {
      householdHead = head;
    });
  }

  void updateHouseholdAmenities(Household amenities) {
    setState(() {
      householdHeadAmenities = amenities;
    });
  }

  Future<void> saveForm() async {
    // Ensure member forms are updated
    for (var key in householdMemberFormKeys) {
      key.currentState?.updateMember();
    }

    Household amenitiesData = Household(
      waterSource: householdHeadAmenities.waterSource,
      garbageDisposal: householdHeadAmenities.garbageDisposal,
      houseStatus: householdHeadAmenities.houseStatus,
      housingMaterial: householdHeadAmenities.housingMaterial,
      toiletFacility: householdHeadAmenities.toiletFacility,
      communication: householdHeadAmenities.communication,
      hhWith: householdHeadAmenities.hhWith,
      hhWithElectricity: householdHeadAmenities.hhWithElectricity,
      income: householdHeadAmenities.income,
    );

    // Save household data and get the generated id
    int householdId = await FormService.saveAndGetHousehold(amenitiesData);

    // Instantiate Household object with form data
    HouseholdHead headData = HouseholdHead(
      name: householdHead.name,
      address: '${householdHead.lot}, ${householdHead.zone}',
      age: householdHead.age,
      gender: householdHead.gender,
      occupation: householdHead.occupation,
      number: householdHead.number,
      civilStatus: householdHead.civilStatus,
      dateOfBirth: householdHead.dateOfBirth,
      religion: householdHead.religion,
      specialGroup: householdHead.specialGroup,
      hhMemberType: 'Head',
      householdId: householdId,
    );

    // List to store HouseholdMember objects
    List<HouseholdMember> membersData = [];

    // Convert each HouseholdMember form data to HouseholdMember object
    for (var i = 0; i < householdMembers.length; i++) {
      String address =
          '${householdMembers[i].lot}, ${householdMembers[i].zone}';
      HouseholdMember memberData = HouseholdMember(
        id: householdMembers[i].id,
        name: householdMembers[i].name,
        address: address,
        age: householdMembers[i].age,
        gender: householdMembers[i].gender,
        occupation: householdMembers[i].occupation,
        number: householdMembers[i].number,
        civilStatus: householdMembers[i].civilStatus,
        dateOfBirth: householdMembers[i].dateOfBirth,
        religion: householdMembers[i].religion,
        specialGroup: householdMembers[i].specialGroup,
        hhMemberType: 'Member',
        householdId: householdId,
      );

      // Add memberData to membersData list
      membersData.add(memberData);
    }

    // Save household member data
    bool membersSaved = await FormService.saveHouseholdMember(membersData);

    // Save household head data
    bool headSaved = await FormService.saveHouseholdHead(headData);

    // Check if all data saved successfully
    if (headSaved && membersSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
                  builder: (context) => CensusData(user: widget.user)),
            );
          },
        ),
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      const Text(
                        'Household Head',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      HouseholdHeadForm(
                        head: householdHead,
                        key: householdHeadFormKey,
                        onRemove: () {},
                        onUpdate: updateHouseholdHead,
                      ),
                      Column(
                        children: householdMembers.asMap().entries.map((entry) {
                          int index = entry.key;
                          HouseholdMember member = entry.value;
                          return HouseholdMemberForm(
                            key: householdMemberFormKeys[index],
                            index: index + 1,
                            member: member,
                            onRemove: () => removeHouseholdMember(index),
                            onUpdate: (updatedMember) =>
                                updateHouseholdMember(index, updatedMember),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                addHouseholdMember();
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text('Add Household Member'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 20.0),
                                textStyle: const TextStyle(fontSize: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Household Amenities and Characteristics',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      HouseholdAmenitiesForm(
                        amenities: householdHeadAmenities,
                        key: householdAmenitiesFormKey,
                        onRemove: () {},
                        onUpdate: updateHouseholdAmenities,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                // prevent from resetting
                                for (var key in householdMemberFormKeys) {
                                  key.currentState?.updateMember();
                                }
                                // Save the form data
                                await saveForm();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CensusData(user: widget.user)),
                                );
                              },
                              icon: const Icon(Icons.save, color: Colors.white),
                              label: const Text('Save'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 20.0),
                                textStyle: const TextStyle(fontSize: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CensusData(user: widget.user)),
                                );
                              },
                              icon: const Icon(Icons.cancel_outlined,
                                  color: Colors.white),
                              label: const Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 20.0),
                                textStyle: const TextStyle(fontSize: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
