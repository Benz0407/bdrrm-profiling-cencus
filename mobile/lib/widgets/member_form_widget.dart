import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/household_member_model.dart';
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
  State<HouseholdMemberForm> createState() => HouseholdMemberFormState();
}

class HouseholdMemberFormState extends State<HouseholdMemberForm> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _dateController;
  late TextEditingController _numberController;
  late TextEditingController _occupationController;

  late GlobalKey<FormState> _formKey;
  Timer? _debounce;

  String? selectedLot;
  String? selectedZone;
  String? selectedReligion;
  String? selectedCivilStatus;
  String? selectedSpecialGroup;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: widget.member.name);
    _ageController = TextEditingController(text: widget.member.age);
    _dateController = TextEditingController(text: widget.member.dateOfBirth);
    _numberController = TextEditingController(text: widget.member.number);
    _occupationController =
        TextEditingController(text: widget.member.occupation);
    selectedLot = widget.member.lot;
    selectedZone = widget.member.zone;
    selectedReligion = widget.member.religion;
    selectedCivilStatus = widget.member.civilStatus;
    selectedGender = widget.member.gender;
    selectedSpecialGroup = widget.member.specialGroup;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _dateController.dispose();
    _numberController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  void updateMember() {
    widget.onUpdate(
      HouseholdMember(
        id: widget.member.id,
        name: _nameController.text,
        lot: selectedLot,
        zone: selectedZone,
        age: _ageController.text,
        gender: selectedGender,
        occupation: _occupationController.text,
        number: _numberController.text,
        civilStatus: selectedCivilStatus,
        dateOfBirth: _dateController.text,
        religion: selectedReligion,
        specialGroup: selectedSpecialGroup,
      ),
    );
  }

  void _onFieldChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      updateMember();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Form(
          key: _formKey,
          child: _buildLayoutForScreenSize(context),
        );
      },
    );
  }

  String get name => _nameController.text;
  String? get lot => selectedLot;
  String? get zone => selectedZone;
  String get age => _ageController.text;
  String? get gender => selectedGender;
  String get occupation => _occupationController.text;
  String get number => _numberController.text;
  String? get civilStatus => selectedCivilStatus;
  String get dateOfBirth => _dateController.text;
  String? get religion => selectedReligion;
  String? get specialGroup => selectedSpecialGroup;

  Widget _buildLayoutForScreenSize(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return buildDesktopLayout();
    } else if (Responsive.isTablet(context)) {
      return buildTabletLayout();
    } else {
      return buildMobileLayout();
    }
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
                  updateMember();
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
                  updateMember();
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
            controller: _nameController,
            decoration: const InputDecoration(
                labelText: 'Last Name', border: OutlineInputBorder()),
            onChanged: (value) {
              _onFieldChanged();
            },
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
            decoration: const InputDecoration(
                labelText: 'Age', border: OutlineInputBorder()),
            onChanged: (value) {
              _onFieldChanged();
            },
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
                  updateMember();
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
          child: DropdownButtonFormField<String>(
            value: selectedGender,
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
            items: ['Male', 'Female']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                selectedGender = newValue;
                updateMember();
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: DropdownButtonFormField<String>(
            value: selectedReligion,
            decoration: const InputDecoration(
              labelText: 'Religion',
              border: OutlineInputBorder(),
            ),
            items: [
              'Catholic',
              'Protestant',
              'Iglesia ni Kristo',
              'Aglipay',
              'Islam',
            ]
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                selectedReligion = newValue;
                updateMember();
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
          child: DropdownButtonFormField<String>(
            value: selectedSpecialGroup,
            decoration: const InputDecoration(
              labelText: 'Special Group',
              border: OutlineInputBorder(),
            ),
            items: ['Senior Citizen', 'Pregnant', 'Minor', 'PWD', 'None']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                selectedSpecialGroup = newValue;
                updateMember();
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextFormField(
            controller: _numberController,
            decoration: const InputDecoration(
                labelText: 'Number', border: OutlineInputBorder()),
            onChanged: (value) {
              _onFieldChanged();
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: DropdownButtonFormField<String>(
            value: selectedCivilStatus,
            decoration: const InputDecoration(
              labelText: 'Civil Status',
              border: OutlineInputBorder(),
            ),
            items: ['Single', 'Married', 'Divorced', 'Widowed']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                selectedCivilStatus = newValue;
                updateMember();
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
            decoration: const InputDecoration(
                labelText: 'Occupation', border: OutlineInputBorder()),
            onChanged: (value) {
              _onFieldChanged();
            },
          ),
        ),
      ],
    );
  }
}
