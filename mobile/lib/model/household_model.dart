class Household {
  int id;
  final String name;
  String? lot;
  String? zone;
  final String age;
  final String gender;
  final String education;
  final String occupation;
  final String number;
  final String civilStatus;
  final DateTime dateOfBirth;
  final String religion;
  final String specialGroup;
  final String waterSource;
  final String garbageDisposal;
  final String houseStatus;
  final String housingMaterial;
  final String toiletFacility;
  final String communication;
  final String hhWith;
  final String hhWithElectricity;
  final String income;

  Household({
    required this.id,
    required this.name,
    this.lot,
    this.zone,
    required this.age,
    required this.gender,
    required this.education,
    required this.occupation,
    required this.number,
    required this.civilStatus,
    required this.dateOfBirth,
    required this.religion,
    required this.specialGroup,
    required this.waterSource,
    required this.garbageDisposal,
    required this.houseStatus,
    required this.housingMaterial,
    required this.toiletFacility,
    required this.communication,
    required this.hhWith,
    required this.hhWithElectricity,
    required this.income,
  });

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      id: json['id'],
      name: json['name'],
      lot: json['lot'],
      zone: json['zone'],
      age: json['age'],
      gender: json['gender'],
      education: json['education'],
      occupation: json['occupation'],
      number: json['number'],
      civilStatus: json['civilStatus'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      religion: json['religion'],
      specialGroup: json['specialGroup'],
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
      'id': id,
      'name': name,
      'lot': lot,
      'zone': zone,
      'age': age,
      'gender': gender,
      'education': education,
      'occupation': occupation,
      'number': number,
      'civilStatus': civilStatus,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'religion': religion,
      'specialGroup': specialGroup,
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
