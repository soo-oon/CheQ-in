class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String userRole;

  User({this.id, this.fullName, this.phoneNumber, this.email, this.userRole});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        phoneNumber = data['phoneNumber'],
        email = data['email'],
        userRole = data['userRole'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'userRole': userRole,
    };
  }
}
