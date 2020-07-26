import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;
  final String userRole;

  User({this.id, this.fullName, this.phoneNumber, this.email, this.address, this.userRole});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
