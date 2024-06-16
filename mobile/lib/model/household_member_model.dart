class HouseholdMember {
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
  String? hhMemberType; 
  int? householdId;
  String? address;  

  HouseholdMember({
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
    this.hhMemberType,
    this.householdId,
    this.lot,
    this.zone
  });

  // Deserialize from JSON
  factory HouseholdMember.fromJson(Map<String, dynamic> json) {
    return HouseholdMember(
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

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : id, 
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
}
