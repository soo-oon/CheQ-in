// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) {
  return Building(
    name: json['name'] as String,
    english_name: json['english_name'] as String,
    department: json['department'] as int,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'name': instance.name,
      'english_name': instance.english_name,
      'department': instance.department,
      'status': instance.status,
    };
