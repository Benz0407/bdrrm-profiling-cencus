import 'package:flutter/material.dart';
import 'package:mobile/census/census_data.dart';
import 'package:mobile/model/household_model.dart';
import 'package:mobile/model/household_member_model.dart';
import 'package:mobile/model/household_head_model.dart';
import 'package:mobile/model/household_table_model.dart';
import 'package:mobile/services/form_service.dart';
import 'package:mobile/widgets/amenities_characteristics_form_widget.dart';
import 'package:mobile/widgets/head_form_widget.dart';
import 'package:mobile/widgets/census_header_widget.dart';
import 'package:mobile/widgets/member_form_widget.dart';

class CensusEditForm extends StatefulWidget {
  final HouseholdTableModel household;

  const CensusEditForm({super.key, required this.household});

  @override
  CensusEditFormState createState() => CensusEditFormState();
}

class CensusEditFormState extends State<CensusEditForm> {
  late HouseholdHead householdHead = HouseholdHead();
  late Household householdHeadAmenities = Household();
  List<HouseholdMember> householdMembers = [];
  List<GlobalKey<HouseholdMemberFormState>> householdMemberFormKeys = [];

  final GlobalKey<HouseholdHeadFormState> householdHeadFormKey =
      GlobalKey<HouseholdHeadFormState>();
  final GlobalKey<HouseholdAmenitiesFormState> householdAmenitiesFormKey =
      GlobalKey<HouseholdAmenitiesFormState>();

  @override
  void initState() {
    super.initState();
    initializeForm();
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

  void initializeForm() {
    // Initialize household head and amenities with data from widget.household
    Member headMember = widget.household.members
        .firstWhere((member) => member.hhMemberType == 'Head');

    householdHead = headMember != null
        ? HouseholdHead(
            id: headMember.id,
            lot: headMember.lot,
            zone: headMember.zone,
            name: headMember.name,
            age: headMember.age,
            gender: headMember.gender,
            occupation: headMember.occupation,
            number: headMember.number,
            civilStatus: headMember.civilStatus,
            dateOfBirth: headMember.dateOfBirth,
            religion: headMember.religion,
            specialGroup: headMember.specialGroup,
            // hhMemberType: headMember.hhMemberType,
            householdId: headMember.householdId)
        : HouseholdHead(); // Default empty constructor

    print("Head id from initialize: ${headMember.id}");
    print("household head id from initialize: ${headMember.householdId}");

    householdHeadAmenities = Household(
      id: widget.household.id,
      waterSource: widget.household.waterSource,
      garbageDisposal: widget.household.garbageDisposal,
      houseStatus: widget.household.houseStatus,
      housingMaterial: widget.household.housingMaterial,
      toiletFacility: widget.household.toiletFacility,
      communication: widget.household.communication,
      hhWith: widget.household.hhWith,
      hhWithElectricity: widget.household.hhWithElectricity,
      income: widget.household.income,
    );

    // Initialize household members with data from widget.household.members
    householdMembers = widget.household.members
        .where((member) => member.hhMemberType == 'Member')
        .map((member) => HouseholdMember(
            id: member.id,
            lot: member.lot,
            zone: member.zone,
            name: member.name,
            age: member.age,
            gender: member.gender,
            occupation: member.occupation,
            number: member.number,
            civilStatus: member.civilStatus,
            dateOfBirth: member.dateOfBirth,
            religion: member.religion,
            specialGroup: member.specialGroup,
            hhMemberType: member.hhMemberType,
            householdId: member.householdId))
        .toList();

    // Initialize form keys for household members
    householdMemberFormKeys = List.generate(
      householdMembers.length,
      (index) => GlobalKey<HouseholdMemberFormState>(),
    );
  }

  void updateHouseholdMember(int index, HouseholdMember member) {
    setState(() {
      householdMembers[index] = member;
    });
  }

  void removeHouseholdMember(int index) {
    setState(() {
      householdMembers.removeAt(index);
      householdMemberFormKeys.removeAt(index);
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
  
  // Prepare Household Amenities Data
  Household amenitiesData = Household(
    id: widget.household.id,
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

  // Update Household Amenities
  bool householdSaved = await FormService.updateHousehold(amenitiesData, amenitiesData.id);

  if (!householdSaved) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error updating household amenities'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Update Household Head
  Member headMember = widget.household.members
      .firstWhere((member) => member.hhMemberType == 'Head');

  HouseholdHead headData = HouseholdHead(
    id: headMember.id,
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
    householdId: headMember.householdId,
  );

  bool headSaved = await FormService.updateHouseholdHead(headData);

  if (!headSaved) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error updating household head'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // List to store HouseholdMember objects
  List<HouseholdMember> membersData = [];

  // Convert each HouseholdMember form data to HouseholdMember object
  for (var i = 0; i < householdMembers.length; i++) {
    HouseholdMember memberData = HouseholdMember(
      id: householdMembers[i].id,
      name: householdMembers[i].name,
      address: '${householdMembers[i].lot}, ${householdMembers[i].zone}',
      age: householdMembers[i].age,
      gender: householdMembers[i].gender,
      occupation: householdMembers[i].occupation,
      number: householdMembers[i].number,
      civilStatus: householdMembers[i].civilStatus,
      dateOfBirth: householdMembers[i].dateOfBirth,
      religion: householdMembers[i].religion,
      specialGroup: householdMembers[i].specialGroup,
      householdId: widget.household.id,
    );
    membersData.add(memberData);
  }

  // Separate existing members (with id) and new members (without id)
  List<HouseholdMember> existingMembers = membersData.where((member) => member.id != null).toList();
  List<HouseholdMember> newMembers = membersData.where((member) => member.id == null).toList();

  // Update existing members
  bool membersSaved = await FormService.updateHouseholdMembers(existingMembers);

  if (!membersSaved) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error updating existing household members'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Insert new members
  bool newMembersSaved = await FormService.saveHouseholdMember(newMembers);

  if (!newMembersSaved) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error saving new household members'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Check if all data saved successfully
  if (householdSaved && headSaved && membersSaved && newMembersSaved) {
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
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
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
            const CensusHeaderWidget(headerText: "Edit Census Form"),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView(
                  children: [
                    const Text(
                      'Household Head',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                    builder: (context) => const CensusData()),
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
            ),
          ],
        ),
      ),
    );
  }
}
