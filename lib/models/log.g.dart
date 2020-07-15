// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) {
  return Log(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    time: json['time'] as String,
  );
}

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'user': instance.user,
      'time': instance.time,
    };
