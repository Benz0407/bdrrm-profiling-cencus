import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/household_model.dart';
import 'package:mobile/util/responsive.dart';

class HouseholdHeadForm extends StatefulWidget {
  final Household head;
  final VoidCallback onRemove;
  final ValueChanged<Household> onUpdate;
  const HouseholdHeadForm(
      {super.key,
      required this.onUpdate,
      required this.onRemove,
      required this.head});

  @override
  State<HouseholdHeadForm> createState() => HouseholdHeadFormState();
}

class HouseholdHeadFormState extends State<HouseholdHeadForm> {
  late TextEditingController _dateController = TextEditingController();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _ageController = TextEditingController();
  late TextEditingController _genderController = TextEditingController();
  late TextEditingController _specialGroupController = TextEditingController();
  late TextEditingController _numberController = TextEditingController();
  late TextEditingController _occupationController = TextEditingController();
  late GlobalKey<FormState> _formKey;

  String? selectedLot;
  String? selectedZone;
  String? selectedReligion;
  String? selectedCivilStatus;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: widget.head.name);
    _ageController = TextEditingController(text: widget.head.age);
    _dateController = TextEditingController(text: widget.head.dateOfBirth);
    _genderController = TextEditingController(text: widget.head.gender);
    _specialGroupController =
        TextEditingController(text: widget.head.specialGroup);
    _numberController = TextEditingController(text: widget.head.number);
    _occupationController = TextEditingController(text: widget.head.occupation);
    selectedLot = widget.head.lot;
    selectedZone = widget.head.zone;
    selectedReligion = widget.head.religion;
    selectedCivilStatus = widget.head.civilStatus;
  }

  void updateHead() {
    widget.onUpdate(
      Household(
        name: _nameController.text,
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
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
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
    );
  }

  Widget buildSpecialGroupNumberAndCivilStatus() {
    return Row(
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
