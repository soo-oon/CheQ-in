import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  final String id;
  String fullName;
  String phoneNumber;
  final String email;
  String address;
  String userRole;

  User(
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.address,
      this.userRole});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
