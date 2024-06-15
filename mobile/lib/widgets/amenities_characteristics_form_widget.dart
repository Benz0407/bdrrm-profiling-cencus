import 'package:flutter/material.dart';
import 'package:mobile/model/household_model.dart';
import 'package:mobile/util/responsive.dart';
import 'dart:async';

class HouseholdAmenitiesForm extends StatefulWidget {
  final Household amenities;
  final VoidCallback onRemove;
  final ValueChanged<Household> onUpdate;
  const HouseholdAmenitiesForm(
      {super.key,
      required this.amenities,
      required this.onRemove,
      required this.onUpdate});

  @override
  State<HouseholdAmenitiesForm> createState() => HouseholdAmenitiesFormState();
}

class HouseholdAmenitiesFormState extends State<HouseholdAmenitiesForm> {
  String? _sourceOfWater;
  String? _garbageDisposal;
  String? _toiletFacility;
  String? _constructionMaterials;
  String? _meansOfCommunication;
  String? _hhWith;
  String? _hhWithElectricity;
  String? _houseStatus;
  late TextEditingController _incomeController = TextEditingController();
  late GlobalKey<FormState> _formKey;
  Timer? _debounce;
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

  final List<String> _houseStatusOptions = [
    'Good',
    'Bad',
  ];

  final List<String> _hhWithElectricityOptions = ['Yes', 'No'];

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _sourceOfWater = widget.amenities.waterSource;
    _garbageDisposal = widget.amenities.garbageDisposal;
    _toiletFacility = widget.amenities.toiletFacility;
    _constructionMaterials = widget.amenities.housingMaterial;
    _hhWith = widget.amenities.hhWith;
    _hhWithElectricity = widget.amenities.hhWithElectricity;
    _houseStatus = widget.amenities.houseStatus;
    _incomeController = TextEditingController(text: widget.amenities.income);
  }

  void updateAmenities() {
    widget.onUpdate(
      Household(
        waterSource: _sourceOfWater,
        garbageDisposal: _garbageDisposal,
        toiletFacility: _toiletFacility,
        housingMaterial: _constructionMaterials,
        communication: _meansOfCommunication,
        hhWith: _hhWith,
        hhWithElectricity: _hhWithElectricity,
        houseStatus: _houseStatus,
        income: _incomeController.text,
      ),
    );
  }

  void _onFieldChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      updateAmenities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
      ),
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
              updateAmenities();
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
              updateAmenities();
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
              updateAmenities();
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
              updateAmenities();
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
              updateAmenities();
            });
          },
        ),
        const SizedBox(height: 10),
        buildDropdown(
          'House Status',
          _houseStatus,
          _houseStatusOptions,
          (newValue) {
            setState(() {
              _houseStatus = newValue;
              updateAmenities();
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
              updateAmenities();
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
              updateAmenities();
            });
          },
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextFormField(
            controller: _incomeController,
            decoration: const InputDecoration(
              labelText: 'Income',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _onFieldChanged();
            },
          ),
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
                    updateAmenities();
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
                    updateAmenities();
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
                    updateAmenities();
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
                    updateAmenities();
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
                    updateAmenities();
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
                'House Status',
                _houseStatus,
                _houseStatusOptions,
                (newValue) {
                  setState(() {
                    _houseStatus = newValue;
                    updateAmenities();
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
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
                    updateAmenities();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: TextFormField(
                controller: _incomeController,
                decoration: const InputDecoration(
                  labelText: 'Income',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _onFieldChanged();
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
                    updateAmenities();
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
                    updateAmenities();
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
                    updateAmenities();
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
                    updateAmenities();
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
                'Means of Communication',
                _meansOfCommunication,
                _meansOfCommunicationOptions,
                (newValue) {
                  setState(() {
                    _meansOfCommunication = newValue;
                    updateAmenities();
                  });
                },
              ),
              const SizedBox(height: 10),
              buildDropdown(
                'House Status',
                _houseStatus,
                _houseStatusOptions,
                (newValue) {
                  setState(() {
                    _houseStatus = newValue;
                    updateAmenities();
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
                    updateAmenities();
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
                    updateAmenities();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const SizedBox(height: 10),
              TextFormField(
                controller: _incomeController,
                decoration: const InputDecoration(
                  labelText: 'Income',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _onFieldChanged();
                },
              ),
            ],)
        )
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
