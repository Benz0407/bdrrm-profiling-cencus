import 'package:flutter/material.dart';
import 'package:mobile/census/census_data.dart';
import 'package:mobile/model/household_amenities.dart';
import 'package:mobile/model/household_member.dart';
import 'package:mobile/model/household_model.dart';
import 'package:mobile/services/form_service.dart';
import 'package:mobile/widgets/amenities_characteristics_form_widget.dart';
import 'package:mobile/widgets/head_form_widget.dart';
import 'package:mobile/widgets/census_header_widget.dart';
import 'package:mobile/widgets/member_form_widget.dart';

class CensusForm extends StatefulWidget {
  const CensusForm({super.key});

  @override
  State<CensusForm> createState() => _CensusFormState();
}

class _CensusFormState extends State<CensusForm> {
   
  Household householdHead = Household();
  HouseholdAmenities householdHeadAmenities = HouseholdAmenities();
  List<HouseholdMember> householdMembers = [];
  List<GlobalKey<HouseholdMemberFormState>> householdMemberFormKeys = [];

  final GlobalKey<HouseholdHeadFormState> householdHeadFormKey = GlobalKey<HouseholdHeadFormState>();
  final GlobalKey<HouseholdAmenitiesFormState> householdAmenitiesFormKey = GlobalKey<HouseholdAmenitiesFormState>();

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
  void updateHouseholdHead(Household head) {
    setState(() {
      householdHead = head;
    });
  }
  void updateHouseholdAmenities(HouseholdAmenities amenities) {
    setState(() {
      householdHeadAmenities = amenities;
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
                    // const HouseholdHeadForm(),

                    HouseholdHeadForm(
                      head: householdHead,
                      key: householdHeadFormKey,
                      onRemove: () {
                        // Handle the removal of the household head if necessary
                      },
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
                    // const HouseholdAmenitiesForm(),
                     HouseholdAmenitiesForm(
                      amenities: householdHeadAmenities,
                      key: householdAmenitiesFormKey,
                      onRemove: () {
                        // Handle the removal of the household head if necessary
                      },
                      onUpdate: updateHouseholdAmenities,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              for (var key in householdMemberFormKeys) {
                                key.currentState?.updateMember();
                              }
                              // Create a Household instance from your form data and save
                              // Household household = Household(
                              //   id: 7, // Set ID as needed, or handle auto-increment on the server side
                              //   name: 'dummy name muna', // Replace with actual data from your form
                              //   // Assign other form fields to corresponding properties
                              //   lot: 'selectedLot',
                              //   zone: 'selectedZone',
                              //   age: '25',
                              //   gender: 'Male',
                              //   occupation: 'IT',
                              //   number: '0909334396',
                              //   civilStatus: 'Single', 
                              //   dateOfBirth: '',
                              //   religion: 'Catholic', 
                              //   specialGroup: 'Senior', 
                              // );

                              // ApiService().saveHouseholdData(household);
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
