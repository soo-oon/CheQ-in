// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    fullName: json['fullName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    userRole: json['userRole'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address' : instance.address,
      'userRole': instance.userRole,
    };
