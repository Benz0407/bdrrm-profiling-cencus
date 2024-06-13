import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HouseholdMemberForm extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;

  const HouseholdMemberForm({
    super.key,
    required this.index,
    required this.onRemove,
  });

  @override
  State<HouseholdMemberForm> createState() => _HouseholdMemberFormState();
}

class _HouseholdMemberFormState extends State<HouseholdMemberForm> {
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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Household Member ${widget.index}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: widget.onRemove,
            ),
          ],
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        const Divider(thickness: 2)
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
