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
      'id' : id, 
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