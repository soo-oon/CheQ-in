import 'log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';

@JsonSerializable(nullable: false)
class Building {
  final String name;
  final int department;
  final int status;
  List<Log> logs;

  Building({this.name, this.department, this.status, this.logs});
  
  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}
