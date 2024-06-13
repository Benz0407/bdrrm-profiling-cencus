class HouseholdMember {
  final int index;
  final String lastName;
  final String firstName;
  final String middleName;
  final String age;
  final String dateOfBirth;
  final String gender;
  final String specialGroupBelong;
  final String number;
  final String religion;
  final String civilStatus;
  final String occupation;

  HouseholdMember({
    required this.index,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.specialGroupBelong,
    required this.number,
    required this.religion,
    required this.civilStatus,
    required this.occupation,
  });

  HouseholdMember copyWith({
    String? lastName,
    String? firstName,
    String? middleName,
    String? age,
    String? dateOfBirth,
    String? gender,
    String? specialGroupBelong,
    String? number,
    String? religion,
    String? civilStatus,
    String? occupation, required int index,
  }) {
    return HouseholdMember(
      index: index,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      age: age ?? this.age,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      specialGroupBelong: specialGroupBelong ?? this.specialGroupBelong,
      number: number ?? this.number,
      religion: religion ?? this.religion,
      civilStatus: civilStatus ?? this.civilStatus,
      occupation: occupation ?? this.occupation,
    );
  }

  HouseholdMember copyWithFields(Map<String, String> fields, String value) {
    return HouseholdMember(
      index: index,
      lastName: fields['lastName'] ?? lastName,
      firstName: fields['firstName'] ?? firstName,
      middleName: fields['middleName'] ?? middleName,
      age: fields['age'] ?? age,
      dateOfBirth: fields['dateOfBirth'] ?? dateOfBirth,
      gender: fields['gender'] ?? gender,
      specialGroupBelong: fields['specialGroupBelong'] ?? specialGroupBelong,
      number: fields['number'] ?? number,
      religion: fields['religion'] ?? religion,
      civilStatus: fields['civilStatus'] ?? civilStatus,
      occupation: fields['occupation'] ?? occupation,
    );
  }
}
