// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) {
  return Log(
    userName: json['userName'] as String,
    buildingName: json['buildingName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    time: json['time'] as String,
    key: json['key'] as String,
  );
}

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'userName': instance.userName,
      'buildingName': instance.buildingName,
      'phoneNumber': instance.phoneNumber,
      'time': instance.time,
      'key': instance.key,
    };
