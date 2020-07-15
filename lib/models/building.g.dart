// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) {
  return Building(
    name: json['name'] as String,
    department: json['department'] as int,
    status: json['status'] as int,
    logs: (json['logs'] as List)
        .map((e) => Log.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'name': instance.name,
      'department': instance.department,
      'status': instance.status,
      'logs': instance.logs.map((e) => e.toJson()).toList(),
};
