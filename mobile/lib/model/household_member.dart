class HouseholdMember {
  String? lastName;
  String? firstName;
  String? middleName;
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

  HouseholdMember({
    this.lastName,
    this.firstName,
    this.middleName,
    this.age,
    this.dateOfBirth,
    this.gender,
    this.religion,
    this.specialGroup,
    this.number,
    this.civilStatus,
    this.occupation,
    this.lot,
    this.zone,
  });

  toJson() {}
}
