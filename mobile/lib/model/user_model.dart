class User {
  int? id;
  String? userName;
  String? email;
  String? password; 
  String? userType;

  User({this.id,  this.userName, this.email,  this.password, this.userType});
  
  Map<String, dynamic> toJson() => {
      'id': id,
      'userName': userName,
      'email': email,
      'password' : password,
      'userType': userType
    };

    
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      userType: json['userType'],
    );
  }
}


