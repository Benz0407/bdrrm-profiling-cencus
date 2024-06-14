class Household {
  int? id;
  final String? name;
  String? lot;
  String? zone;
  final String? age;
  final String? gender;
  final String? occupation;
  final String? number;
  final String? civilStatus;
  final String? dateOfBirth;
  final String? religion;
  final String? specialGroup;

  Household({
    this.id,
    this.name,
    this.lot,
    this.zone,
    this.age,
    this.gender,
    this.occupation,
    this.number,
    this.civilStatus,
    this.dateOfBirth,
    this.religion,
    this.specialGroup,
  });

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      id: json['id'],
      name: json['name'],
      lot: json['lot'],
      zone: json['zone'],
      age: json['age'],
      gender: json['gender'],
      occupation: json['occupation'],
      number: json['number'],
      civilStatus: json['civilStatus'],
      dateOfBirth: json['dateOfBirth'],
      religion: json['religion'],
      specialGroup: json['specialGroup'],
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
      'occupation': occupation,
      'number': number,
      'civilStatus': civilStatus,
      'dateOfBirth': dateOfBirth,
      'religion': religion,
      'specialGroup': specialGroup,
    };
  }
}
