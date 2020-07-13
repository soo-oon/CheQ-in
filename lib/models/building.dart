import 'log.dart';

enum Department {
  Engineering,
  Sport,
  Medical,
  Center,
}

enum Status { infected, cleaned, normal }

class Building {
  final String id;
  final String name;
  final Department department;
  final Status status;
  final List<Log> logs;

  Building({this.id, this.name, this.department, this.status, this.logs});

  Building.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        department = data['department'],
        status = data['status'],
        logs = data['logs'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'status': status,
      'logs': logs,
    };
  }
}
