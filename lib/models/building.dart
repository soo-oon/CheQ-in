import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';

@JsonSerializable(nullable: false)
class Building {
  final String name;
  // ignore: non_constant_identifier_names
  final String english_name;
  final int department;
  int status;

  // ignore: non_constant_identifier_names
  Building({this.name, this.department, this.status, this.english_name});

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}
