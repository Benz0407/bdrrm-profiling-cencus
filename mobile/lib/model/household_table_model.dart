class HouseholdTableModel {
  final id; 
  final String name;
  final String address;
  final String age;
  final String occupation;
  final String number;
  final String civilStatus;
  final String dateOfBirth;
  final String religion;
  final String specialGroup;
  final String gender;
  final String hhMemberType;
  final List<Member> members;
  final String waterSource;
  final String garbageDisposal;
  final String houseStatus;
  final String toiletFacility;
  final String housingMaterial;
  final String communication;
  final String hhWith;
  final String income;
  final String hhWithElectricity;

  HouseholdTableModel({
    required this.id,
    required this.name,
    required this.address,
    required this.age,
    required this.occupation,
    required this.number,
    required this.civilStatus,
    required this.dateOfBirth,
    required this.religion,
    required this.specialGroup,
    required this.gender,
    required this.hhMemberType,
    required this.members,
    required this.waterSource,
    required this.garbageDisposal,
    required this.houseStatus,
    required this.toiletFacility,
    required this.housingMaterial,
    required this.communication,
    required this.hhWith,
    required this.income,
    required this.hhWithElectricity,
  });

  factory HouseholdTableModel.fromJson(Map<String, dynamic> json) {
    // print('Parsing Household: $json');
    // Handle null values by empty values
    return HouseholdTableModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      age: json['age'] ?? '',
      occupation: json['occupation'] ?? '',
      number: json['number'] ?? '',
      civilStatus: json['civil_status'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      religion: json['religion'] ?? '',
      specialGroup: json['special_group'] ?? '',
      gender: json['gender'] ?? '',
      hhMemberType: json['hh_member_type'] ?? '',
      members: (json['members'] as List? ?? [])
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      waterSource: json['waterSource'] ?? '',
      garbageDisposal: json['garbageDisposal'] ?? '',
      houseStatus: json['houseStatus'] ?? '',
      toiletFacility: json['toiletFacility'] ?? '',
      housingMaterial: json['housingMaterial'] ?? '',
      communication: json['communication'],
      hhWith: json['hhWith'] ?? '',
      income: json['income'] ?? '',
      hhWithElectricity: json['hhWithElectricity'] ?? '',
    );
  }
}

class Member {
  final String name;
  final String address;
  final String age;
  final String gender;
  final String occupation;
  final String number;
  final String civilStatus;
  final String dateOfBirth;
  final String religion;
  final String specialGroup;
  final String hhMemberType;

  Member({
    required this.name,
    required this.address,
    required this.age,
    required this.gender,
    required this.occupation,
    required this.number,
    required this.civilStatus,
    required this.dateOfBirth,
    required this.religion,
    required this.specialGroup,
    required this.hhMemberType,
  });

  Member.empty()
      : name = '',
        address = '',
        age = '',
        gender = '',
        occupation = '',
        number = '',
        civilStatus = '',
        dateOfBirth = '',
        religion = '',
        specialGroup = '',
        hhMemberType = '';

  factory Member.fromJson(Map<String, dynamic> json) {
    // Handle null values by providing default or empty values
    return Member(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      occupation: json['occupation'] ?? '',
      number: json['number'] ?? '',
      civilStatus: json['civil_status'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      religion: json['religion'] ?? '',
      specialGroup: json['special_group'] ?? '',
      hhMemberType: json['hh_member_type'] ?? '',
    );
  }
}
