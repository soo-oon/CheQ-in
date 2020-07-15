import 'log.dart';

enum Department {
  Engineering,
  Sport,
  Medical,
  Center,
}

enum Status { infected, cleaned, normal }

class Building {
  String id;
  String name;
  Department department;
  Status status;
  List<Log> logs;

  Building({this.id, this.name, this.department, this.status, this.logs});

  Building.fromData(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];

    if (data['logs'] != null) {
      logs = new List<Log>();
      data['logs'].forEach((v) {
        logs.add(new Log.fromData(v));
      });
    } else {
      logs = [];
    }

    switch (data['department']) {
      case 0:
        department = Department.Engineering;
        break;
      case 1:
        department = Department.Sport;
        break;
      case 2:
        department = Department.Medical;
        break;
      case 3:
        department = Department.Center;
        break;
      default:
        break;
    }
    switch (data['status']) {
      case 0:
        status = Status.cleaned;
        break;
      case 1:
        status = Status.infected;
        break;
      case 2:
        status = Status.normal;
        break;
      default:
        break;
    }
  }

  Map<String, dynamic> toJson() {
    int transDepartment = 0;
    int transStatus = 0;

    switch (department) {
      case Department.Engineering:
        transDepartment = 0;
        break;
      case Department.Sport:
        transDepartment = 1;
        break;
      case Department.Medical:
        transDepartment = 2;
        break;
      case Department.Center:
        transDepartment = 3;
        break;
      default:
        break;
    }
    switch (status) {
      case Status.cleaned:
        transStatus = 0;
        break;
      case Status.infected:
        transStatus = 1;
        break;
      case Status.normal:
        transStatus = 2;
        break;
      default:
        break;
    }
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.logs != null) {
      data['logs'] = this.logs.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = transStatus;
    data['department'] = transDepartment;
    return data;
  }
}
