class HouseholdAmenities {
  final String? waterSource;
  final String? garbageDisposal;
  final String? houseStatus;
  final String? housingMaterial;
  final String? toiletFacility;
  final String? communication;
  final String? hhWith;
  final String? hhWithElectricity;
  final String? income;

  HouseholdAmenities({
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

  factory HouseholdAmenities.fromJson(Map<String, dynamic> json) {
    return HouseholdAmenities(
      waterSource: json['waterSource'],
      garbageDisposal: json['garbageDisposal'],
      houseStatus: json['houseStatus'],
      housingMaterial: json['housingMaterial'],
      toiletFacility: json['toiletFacility'],
      communication: json['communication'],
      hhWith: json['hhWith'],
      hhWithElectricity: json['hhWithElectricity'],
      income: json['income'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waterSource': waterSource,
      'garbageDisposal': garbageDisposal,
      'houseStatus': houseStatus,
      'housingMaterial': housingMaterial,
      'toiletFacility': toiletFacility,
      'communication': communication,
      'hhWith': hhWith,
      'hhWithElectricity': hhWithElectricity,
      'income': income,
    };
  }

}