import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/household_member.dart';
import 'package:mobile/util/responsive.dart';

class HouseholdMemberForm extends StatefulWidget {
  final int index;
  final HouseholdMember member;
  final VoidCallback onRemove;
  final ValueChanged<HouseholdMember> onUpdate;

  const HouseholdMemberForm({
    super.key,
    required this.index,
    required this.member,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<HouseholdMemberForm> createState() => _HouseholdMemberFormState();
}

class _HouseholdMemberFormState extends State<HouseholdMemberForm> {
  late TextEditingController _lastNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _ageController;
  late TextEditingController _dateController;
  late TextEditingController _genderController;
  late TextEditingController _specialGroupController;
  late TextEditingController _numberController;
  late TextEditingController _occupationController;

  String? selectedLot;
  String? selectedZone;
  String? selectedReligion;
  String? selectedCivilStatus;

  @override
  void initState() {
    super.initState();
    _lastNameController = TextEditingController(text: widget.member.lastName);
    _firstNameController = TextEditingController(text: widget.member.firstName);
    _middleNameController = TextEditingController(text: widget.member.middleName);
    _ageController = TextEditingController(text: widget.member.age);
    _dateController = TextEditingController(text: widget.member.dateOfBirth);
    _genderController = TextEditingController(text: widget.member.gender);
    _specialGroupController = TextEditingController(text: widget.member.specialGroup);
    _numberController = TextEditingController(text: widget.member.number);
    _occupationController = TextEditingController(text: widget.member.occupation);

    selectedLot = widget.member.lot;
    selectedZone = widget.member.zone;
    selectedReligion = widget.member.religion;
    selectedCivilStatus = widget.member.civilStatus;
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _ageController.dispose();
    _dateController.dispose();
    _genderController.dispose();
    _specialGroupController.dispose();
    _numberController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  void _updateMember() {
    widget.onUpdate(
      HouseholdMember(
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        age: _ageController.text,
        dateOfBirth: _dateController.text,
        gender: _genderController.text,
        religion: selectedReligion,
        specialGroup: _specialGroupController.text,
        number: _numberController.text,
        civilStatus: selectedCivilStatus,
        occupation: _occupationController.text,
        lot: selectedLot,
        zone: selectedZone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Responsive.isDesktop(context)) {
          return buildDesktopLayout();
        } else if (Responsive.isTablet(context)) {
          return buildTabletLayout();
        } else {
          return buildMobileLayout();
        }
      },
    );
  }

  Widget buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        buildHeader(),
        const SizedBox(height: 20),
        buildLotAndZone(),
        const SizedBox(height: 8),
        buildNameFields(),
        const SizedBox(height: 8),
        buildAgeGenderAndReligion(),
        const SizedBox(height: 8),
        buildSpecialGroupNumberAndCivilStatus(),
        const SizedBox(height: 8),
        buildOccupation(),
        const SizedBox(height: 20),
        const Divider(thickness: 2)
      ],
    );
  }

  Widget buildTabletLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        buildHeader(),
        const SizedBox(height: 20),
        buildLotAndZone(),
        const SizedBox(height: 8),
        buildNameFields(),
        const SizedBox(height: 8),
        buildAgeGenderAndReligion(),
        const SizedBox(height: 8),
        buildSpecialGroupNumberAndCivilStatus(),
        const SizedBox(height: 8),
        buildOccupation(),
        const SizedBox(height: 20),
        const Divider(thickness: 2)
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        buildHeader(),
        const SizedBox(height: 20),
        buildLotAndZone(),
        const SizedBox(height: 8),
        buildNameFields(),
        const SizedBox(height: 8),
        buildAgeGenderAndReligion(),
        const SizedBox(height: 8),
        buildSpecialGroupNumberAndCivilStatus(),
        const SizedBox(height: 8),
        buildOccupation(),
        const SizedBox(height: 20),
        const Divider(thickness: 2)
      ],
    );
  }

  Widget buildHeader() {
    return Row(
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
    );
  }

  Widget buildLotAndZone() {
    return Container(
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
                  _updateMember();
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
                  _updateMember();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNameFields() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: _lastNameController,
            onChanged: (value) => _updateMember(),
            decoration: const InputDecoration(
                labelText: 'Last Name', border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextFormField(
            controller: _firstNameController,
            onChanged: (value) => _updateMember(),
            decoration: const InputDecoration(
                labelText: 'Given/First Name',
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextFormField(
            controller: _middleNameController,
            onChanged: (value) => _updateMember(),
            decoration: const InputDecoration(
                labelText: 'Middle Name', border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }

  Widget buildAgeGenderAndReligion() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: _ageController,
            onChanged: (value) => _updateMember(),
            decoration: const InputDecoration(
                labelText: 'Age', border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: GestureDetector(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  _dateController.text =
                      DateFormat('yyyy-MM-dd').format(picked);
                  _updateMember();
                });
              }
            },
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
            onChanged: (value) => _updateMember(),
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
                _updateMember();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildSpecialGroupNumberAndCivilStatus() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: _specialGroupController,
            onChanged: (value) => _updateMember(),
            decoration: const InputDecoration(
                labelText: 'Special Group Belong',
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextFormField(
            controller: _numberController,
            onChanged: (value) => _updateMember(),
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
                _updateMember();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildOccupation() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: _occupationController,
            onChanged: (value) => _updateMember(),
            decoration: const InputDecoration(
                labelText: 'Occupation', border: OutlineInputBorder()),
          ),
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
