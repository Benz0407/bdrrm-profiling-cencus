import 'package:flutter/material.dart';
import 'package:mobile/util/responsive.dart';

class HouseholdAmenitiesForm extends StatefulWidget {
  const HouseholdAmenitiesForm({super.key});

  @override
  State<HouseholdAmenitiesForm> createState() => _HouseholdAmenitiesFormState();
}

class _HouseholdAmenitiesFormState extends State<HouseholdAmenitiesForm> {
  String? _sourceOfWater;
  String? _garbageDisposal;
  String? _toiletFacility;
  String? _constructionMaterials;
  String? _meansOfCommunication;
  String? _hhWith;
  String? _hhWithElectricity;

  final List<String> _sourceOfWaterOptions = [
    'Community Water System (Owned)',
    'Community Water System (Shared)',
    'Deep and Shallow Well (Owned)',
    'Deep and Shallow Well (Shared)',
    'Bottled Water/Purified/Distilled Water'
  ];

  final List<String> _garbageDisposalOptions = [
    'Garbage Collection',
    'Burning',
    'Composting',
    'Recycling',
    'Waste Segreg'
  ];

  final List<String> _toiletFacilityOptions = [
    'Level 1- Unsanitary Toilet',
    'Level 2- Sanitary Toilet with Septic Tank',
    'Level 3- None'
  ];

  final List<String> _constructionMaterialsOptions = [
    'Strong Materials',
    'Light Materials',
    'Mixed Materials'
  ];

  final List<String> _meansOfCommunicationOptions = [
    'Telephone',
    'Cellphone',
    'Internet'
  ];

  final List<String> _hhWithOptions = [
    'Vegetable Garden',
    'Poultry',
    'Livestock',
    'Fishpond'
  ];

  final List<String> _hhWithElectricityOptions = ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            if (Responsive.isDesktop(context)) {
              return buildDesktopLayout();
            } else if (Responsive.isTablet(context)) {
              return buildTabletLayout();
            } else {
              return buildMobileLayout();
            }
          },
        ),
      ],
    );
  }

  Widget buildMobileLayout() {
    return Column(
      children: [
        buildDropdown(
          'Source of Water',
          _sourceOfWater,
          _sourceOfWaterOptions,
          (newValue) {
            setState(() {
              _sourceOfWater = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'Toilet Facility',
          _toiletFacility,
          _toiletFacilityOptions,
          (newValue) {
            setState(() {
              _toiletFacility = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'Garbage Disposal',
          _garbageDisposal,
          _garbageDisposalOptions,
          (newValue) {
            setState(() {
              _garbageDisposal = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'Construction Materials',
          _constructionMaterials,
          _constructionMaterialsOptions,
          (newValue) {
            setState(() {
              _constructionMaterials = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'Means of Communication',
          _meansOfCommunication,
          _meansOfCommunicationOptions,
          (newValue) {
            setState(() {
              _meansOfCommunication = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'HH with',
          _hhWith,
          _hhWithOptions,
          (newValue) {
            setState(() {
              _hhWith = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'HH with Electricity',
          _hhWithElectricity,
          _hhWithElectricityOptions,
          (newValue) {
            setState(() {
              _hhWithElectricity = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget buildTabletLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: buildDropdown(
                'Source of Water',
                _sourceOfWater,
                _sourceOfWaterOptions,
                (newValue) {
                  setState(() {
                    _sourceOfWater = newValue;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDropdown(
                'Toilet Facility',
                _toiletFacility,
                _toiletFacilityOptions,
                (newValue) {
                  setState(() {
                    _toiletFacility = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: buildDropdown(
                'Garbage Disposal',
                _garbageDisposal,
                _garbageDisposalOptions,
                (newValue) {
                  setState(() {
                    _garbageDisposal = newValue;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDropdown(
                'Construction Materials',
                _constructionMaterials,
                _constructionMaterialsOptions,
                (newValue) {
                  setState(() {
                    _constructionMaterials = newValue;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDropdown(
                'Means of Communication',
                _meansOfCommunication,
                _meansOfCommunicationOptions,
                (newValue) {
                  setState(() {
                    _meansOfCommunication = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: buildDropdown(
                'HH with',
                _hhWith,
                _hhWithOptions,
                (newValue) {
                  setState(() {
                    _hhWith = newValue;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDropdown(
                'HH with Electricity',
                _hhWithElectricity,
                _hhWithElectricityOptions,
                (newValue) {
                  setState(() {
                    _hhWithElectricity = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(
                'Source of Water',
                _sourceOfWater,
                _sourceOfWaterOptions,
                (newValue) {
                  setState(() {
                    _sourceOfWater = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              buildDropdown(
                'Toilet Facility',
                _toiletFacility,
                _toiletFacilityOptions,
                (newValue) {
                  setState(() {
                    _toiletFacility = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              buildDropdown(
                'Garbage Disposal',
                _garbageDisposal,
                _garbageDisposalOptions,
                (newValue) {
                  setState(() {
                    _garbageDisposal = newValue;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(
                'Construction Materials',
                _constructionMaterials,
                _constructionMaterialsOptions,
                (newValue) {
                  setState(() {
                    _constructionMaterials = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              buildDropdown(
                'Means of Communication',
                _meansOfCommunication,
                _meansOfCommunicationOptions,
                (newValue) {
                  setState(() {
                    _meansOfCommunication = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              buildDropdown(
                'HH with',
                _hhWith,
                _hhWithOptions,
                (newValue) {
                  setState(() {
                    _hhWith = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              buildDropdown(
                'HH with Electricity',
                _hhWithElectricity,
                _hhWithElectricityOptions,
                (newValue) {
                  setState(() {
                    _hhWithElectricity = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDropdown(String labelText, String? value, List<String> items,
      void Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        items: items.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
