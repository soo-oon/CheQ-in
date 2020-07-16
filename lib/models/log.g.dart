// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) {
  return Log(
    userName: json['userName'] as String,
    buildingName: json['buildingName'] as String,
    time: json['time'] as String,
  );
}

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'userName': instance.userName,
      'buildingName': instance.buildingName,
      'time': instance.time,
    };
