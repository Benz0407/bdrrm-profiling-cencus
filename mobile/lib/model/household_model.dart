class Household {
  int? id; 
  final String? waterSource;
  final String? garbageDisposal;
  final String? houseStatus;
  final String? housingMaterial;
  final String? toiletFacility;
  final String? communication;
  final String? hhWith;
  final String? hhWithElectricity;
  final String? income;

  Household({
    this.id, 
    this.waterSource,
     this.garbageDisposal,
     this.houseStatus,
     this.housingMaterial,
     this.toiletFacility,
     this.communication,
     this.hhWith,
     this.hhWithElectricity,
     this.income,
  });

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      id:  int.parse(json['id']),
      waterSource: json['water_source'],
      garbageDisposal: json['garbage_disposal'],
      houseStatus: json['house_status'],
      housingMaterial: json['housing_material'],
      toiletFacility: json['toilet_facility'],
      communication: json['communication'],
      hhWith: json['hh_with'],
      hhWithElectricity: json['hh_with_electricity'],
      income: json['income'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id, 
      'water_source': waterSource,
      'garbage_disposal': garbageDisposal,
      'house_status': houseStatus,
      'housing_material': housingMaterial,
      'toilet_facility': toiletFacility,
      'communication': communication,
      'hh_with': hhWith,
      'hh_with_electricity': hhWithElectricity,
      'income': income,
    };
  }

@override
  String toString() {
    return 'HouseholdAmenities{id: id, communication: $communication, garbageDisposal: $garbageDisposal, houseStatus: $houseStatus, housingMaterial: $housingMaterial, '
        'toiletFacility: $toiletFacility, communication: $communication, hhWith: $hhWith, '
        'hhWithElectricity: $hhWithElectricity, income: $income}';
  }


}