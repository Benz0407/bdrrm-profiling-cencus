class HouseholdHead {
  int? id;
  String? name;
  String? age;
  String? dateOfBirth;
  String? gender;
  String? religion;
  String? specialGroup;
  String? number;
  String? civilStatus;
  String? occupation;
  String? lot;
  String? zone;
  String hhMemberType; 
  int? householdId;
  String? address; 

  HouseholdHead({
    this.id, 
    this.name,
    this.address,
    this.age,
    this.gender,
    this.occupation,
    this.number,
    this.civilStatus,
    this.dateOfBirth,
    this.religion,
    this.specialGroup,
    this.hhMemberType  = 'Head',
    this.householdId,
    this.lot,
    this.zone, 
  });

  factory HouseholdHead.fromJson(Map<String, dynamic> json) {
    return HouseholdHead(
     // Adjust according to your API response
      id: int.parse(json['id']),
      name: json['name'],
      address: '${json['lot']} ${json['zone']}',
      age: json['age'],
      gender: json['gender'],
      occupation: json['occupation'],
      number: json['number'],
      civilStatus: json['civil_status'],
      dateOfBirth: json['date_of_birth'],
      religion: json['religion'],
      specialGroup: json['special_group'],
      hhMemberType: json['hh_member_type'],
      householdId: int.parse(json['household_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id, 
      'name': name,
      'address': address,
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'number': number,
      'civil_status': civilStatus,
      'date_of_birth': dateOfBirth,
      'religion': religion,
      'special_group': specialGroup,
      'hh_member_type': hhMemberType,
      'household_id': householdId,
    };
  }


@override
  String toString() {
    return 'HouseholdHead{name: $name, lot: $lot, zone: $zone, age: $age, '
        'gender: $gender, occupation: $occupation, number: $number, '
        'civilStatus: $civilStatus, dateOfBirth: $dateOfBirth, '
        'religion: $religion, specialGroup: $specialGroup, '
        'householdId: $householdId, hhMemberType: $hhMemberType}';
  }

}
