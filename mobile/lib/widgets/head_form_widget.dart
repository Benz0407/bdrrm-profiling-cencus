import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HouseholdHeadForm extends StatefulWidget {
  const HouseholdHeadForm({super.key});

  @override
  State<HouseholdHeadForm> createState() => _HouseholdHeadFormState();
}

class _HouseholdHeadFormState extends State<HouseholdHeadForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _specialGroupController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();

  String? selectedLot;
  String? selectedZone;
  String? selectedReligion;
  String? selectedCivilStatus;

  @override
  void dispose() {
    _dateController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _specialGroupController.dispose();
    _numberController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.3,
          ),
          child: Row(
            children: [
              Flexible(
                child: DropdownButtonFormField<String>(
                  value: selectedLot,
                  decoration: const InputDecoration(
                    labelText: 'Lot',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(
                    10,
                    (index) => DropdownMenuItem(
                      value: 'Lot ${index + 1}',
                      child: Text('Lot ${index + 1}'),
                    ),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedLot = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: DropdownButtonFormField<String>(
                  value: selectedZone,
                  decoration: const InputDecoration(
                    labelText: 'Zone',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(
                    10,
                    (index) => DropdownMenuItem(
                      value: 'Zone ${index + 1}',
                      child: Text('Zone ${index + 1}'),
                    ),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedZone = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                    labelText: 'Last Name', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                    labelText: 'Given/First Name',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextFormField(
                controller: _middleNameController,
                decoration: const InputDecoration(
                    labelText: 'Middle Name', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                    labelText: 'Age', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(
                    labelText: 'Gender', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: buildDropdownFormField(
                labelText: 'Religion',
                value: selectedReligion,
                items: [
                  'Catholic',
                  'Protestant',
                  'Iglesia ni Kristo',
                  'Aglipay',
                  'Islam',
                  'Others (Specify)'
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedReligion = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: _specialGroupController,
                decoration: const InputDecoration(
                    labelText: 'Special Group Belong',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                    labelText: 'Number', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: buildDropdownFormField(
                labelText: 'Civil Status',
                value: selectedCivilStatus,
                items: [
                  'Single',
                  'Legally Married',
                  'Widowed',
                  'Divorced/Separated',
                  'Common Law/ Live in'
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedCivilStatus = newValue;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextFormField(
                controller: _occupationController,
                decoration: const InputDecoration(
                    labelText: 'Occupation', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownFormField({
    required String labelText,
    String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}


// String? _sourceOfWater;
// String? _garbageDisposal;
// String? _toiletFacility;
// String? _constructionMaterials;
// String? _meansOfCommunication;
// String? _hhWith;
// String? _hhWithElectricity;

// final List<String> _sourceOfWaterOptions = [
//   'Community Water System (Owned)',
//   'Community Water System (Shared)',
//   'Deep and Shallow Well (Owned)',
//   'Deep and Shallow Well (Shared)',
//   'Bottled Water/Purified/Distilled Water'
// ];

// final List<String> _garbageDisposalOptions = [
//   'Garbage Collection',
//   'Burning',
//   'Composting',
//   'Recycling',
//   'Waste Segreg'
// ];

// final List<String> _toiletFacilityOptions = [
//   'Level 1- Unsanitary Toilet',
//   'Level 2- Sanitary Toilet with Septic Tank',
//   'Level 3- None'
// ];

// final List<String> _constructionMaterialsOptions = [
//   'Strong Materials',
//   'Light Materials',
//   'Mixed Materials'
// ];

// final List<String> _meansOfCommunicationOptions = [
//   'Telephone',
//   'Cellphone',
//   'Internet'
// ];

// final List<String> _hhWithOptions = [
//   'Vegetable Garden',
//   'Poultry',
//   'Livestock',
//   'Fishpond'
// ];

// final List<String> _hhWithElectricityOptions = ['Yes', 'No'];

// class HouseholdAmenitiesForm extends StatelessWidget {
//   const HouseholdAmenitiesForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: GridView.count(
//         crossAxisCount: 4, // 2 columns
//         childAspectRatio: 10.0, // Controls the height of each item
//         padding: const EdgeInsets.all(16.0),
//         shrinkWrap: true, // Allows GridView to scroll inside ListView
//         children: [
//           buildDropdown(
//               'Source of Water', _sourceOfWater, _sourceOfWaterOptions,
//               (newValue) {
//             _sourceOfWater = newValue;
//           }),
//           buildDropdown(
//               'Garbage Disposal', _garbageDisposal, _garbageDisposalOptions,
//               (newValue) {
//             _garbageDisposal = newValue;
//           }),
//           buildDropdown(
//               'Toilet Facility', _toiletFacility, _toiletFacilityOptions,
//               (newValue) {
//             _toiletFacility = newValue;
//           }),
//           buildDropdown('Construction Materials', _constructionMaterials,
//               _constructionMaterialsOptions, (newValue) {
//             _constructionMaterials = newValue;
//           }),
//           buildDropdown('Means of Communication', _meansOfCommunication,
//               _meansOfCommunicationOptions, (newValue) {
//             _meansOfCommunication = newValue;
//           }),
//           buildDropdown('HH with', _hhWith, _hhWithOptions, (newValue) {
//             _hhWith = newValue;
//           }),
//           buildDropdown('HH with Electricity', _hhWithElectricity,
//               _hhWithElectricityOptions, (newValue) {
//             _hhWithElectricity = newValue;
//           }),
//         ],
//       ),
//     );
//   }

//   Widget buildDropdown(String labelText, String? value, List<String> items,
//       void Function(String?) onChanged) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: const OutlineInputBorder(),
//         ),
//         items: items.map((String option) {
//           return DropdownMenuItem<String>(
//             value: option,
//             child: Text(option),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
