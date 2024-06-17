import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/household_head_model.dart';
import 'package:mobile/util/responsive.dart';
import 'dart:async';

class HouseholdHeadForm extends StatefulWidget {
  final HouseholdHead head;
  final VoidCallback onRemove;
  final ValueChanged<HouseholdHead> onUpdate;

  const HouseholdHeadForm({
    super.key,
    required this.onUpdate,
    required this.onRemove,
    required this.head,
  });

  @override
  State<HouseholdHeadForm> createState() => HouseholdHeadFormState();
}

class HouseholdHeadFormState extends State<HouseholdHeadForm> {
  late TextEditingController _dateController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _numberController;
  late TextEditingController _occupationController;
  late GlobalKey<FormState> _formKey;

  String? selectedLot;
  String? selectedZone;
  String? selectedReligion;
  String? selectedCivilStatus;
  String? selectedSpecialGroup;
  String? selectedGender;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: widget.head.name);
    _ageController = TextEditingController(text: widget.head.age);
    _dateController = TextEditingController(text: widget.head.dateOfBirth);
    _numberController = TextEditingController(text: widget.head.number);
    _occupationController = TextEditingController(text: widget.head.occupation);
    selectedLot = widget.head.lot;
    selectedZone = widget.head.zone;
    selectedReligion = widget.head.religion;
    selectedCivilStatus = widget.head.civilStatus;
    selectedSpecialGroup = widget.head.specialGroup;
    selectedGender = widget.head.gender;
  }

  void updateHead() {
    widget.onUpdate(
      HouseholdHead(
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
      updateHead();
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _numberController.dispose();
    _occupationController.dispose();
    _debounce?.cancel();
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
        updateHead();
      });
    }
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
        buildLotAndZone(),
        const SizedBox(height: 8),
        buildNameFields(),
        const SizedBox(height: 8),
        buildAgeGenderAndReligion(),
        const SizedBox(height: 8),
        buildSpecialGroupNumberAndCivilStatus(),
        const SizedBox(height: 8),
        buildOccupation(),
      ],
    );
  }

  Widget buildTabletLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLotAndZone(),
        const SizedBox(height: 8),
        buildNameFields(),
        const SizedBox(height: 8),
        buildAgeGenderAndReligion(),
        const SizedBox(height: 8),
        buildSpecialGroupNumberAndCivilStatus(),
        const SizedBox(height: 8),
        buildOccupation(),
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLotAndZone(),
        const SizedBox(height: 8),
        buildNameFields(),
        const SizedBox(height: 8),
        buildAgeGenderAndReligion(),
        const SizedBox(height: 8),
        buildSpecialGroupNumberAndCivilStatus(),
        const SizedBox(height: 8),
        buildOccupation(),
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
                  updateHead();
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
                  updateHead();
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
                labelText: 'Full name', border: OutlineInputBorder()),
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
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _onFieldChanged();
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: buildDropdownFormField(
            labelText: 'Gender',
            value: selectedGender,
            items: ['Male', 'Female'],
            onChanged: (newValue) {
              setState(() {
                selectedGender = newValue;
                updateHead();
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: buildDropdownFormField(
            labelText: 'Religion',
            value: selectedReligion,
            items: [
              'Roman Catholic',
              'Protestant',
              'Iglesia ni Kristo',
              'Aglipay',
              'Islam',
            ],
            onChanged: (newValue) {
              setState(() {
                selectedReligion = newValue;
                updateHead();
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
          child: buildDropdownFormField(
            labelText: 'Special Group',
            value: selectedSpecialGroup,
            items: ['Senior Citizen', 'Pregnant', 'Minor', 'PWD', 'None'],
            onChanged: (newValue) {
              setState(() {
                selectedSpecialGroup = newValue;
                updateHead();
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
          child: buildDropdownFormField(
            labelText: 'Civil Status',
            value: selectedCivilStatus,
            items: [
              'Single',
              'Married',
              'Widowed',
              'Divorced',
            ],
            onChanged: (newValue) {
              setState(() {
                selectedCivilStatus = newValue;
                updateHead();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildOccupation() {
    return TextFormField(
      controller: _occupationController,
      decoration: const InputDecoration(
          labelText: 'Occupation', border: OutlineInputBorder()),
      onChanged: (value) {
        _onFieldChanged();
      },
    );
  }

  Widget buildDropdownFormField({
    required String labelText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
