import 'package:checkin/models/models.dart';
import 'package:checkin/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitedViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  SharedPreferences _prefs;
  List<String> visitedBuildings = [];
  List<String> removedBuildings = [];
  String lastStop = "";
  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  final int _12months = 1200;
  final int _threeWeek = 21;

  void fetchBuildings() async {
    _buildings = await _firestoreService.getBuildings();
  }

  init() async {
    setBusy(true);
    _buildings = await _firestoreService.getBuildings();
    _prefs = await SharedPreferences.getInstance();
    if (lastStop == "") lastStop = _prefs.getString("last");
    visitedBuildings = _prefs.getStringList("buildings");
    updateBuilding();
    exceptBuildingVisitedOverThreeWeek();
    setBusy(false);
  }

  void updateBuilding() {
    if (_firestoreService.visitedBuildingNames != null) {
      if (_firestoreService.visitedBuildingNames.isNotEmpty) {
        for (var i in _firestoreService.visitedBuildingNames) {
          if (!visitedBuildings.contains(i)) visitedBuildings.add(i);
          _prefs.setInt(i, DateTime.now().month * 100 + DateTime.now().day);
        }
        lastStop = _firestoreService.visitedBuildingNames[
            _firestoreService.visitedBuildingNames.length - 1];
        _prefs.setString("last", lastStop);
        _prefs.setStringList("buildings", visitedBuildings);
        _firestoreService.visitedBuildingNames.clear();
      }
    }
  }

  void exceptBuildingVisitedOverThreeWeek() {
    for (var visitedBuilding in visitedBuildings) {
      if (checkOverThreeWeek(visitedBuilding)) {
        removedBuildings.add(visitedBuilding);
      }
    }
    removedBuildings.forEach((f) {
      visitedBuildings.remove(f);
    });
  }

  bool checkOverThreeWeek(String visitedBuilding) {
    int differenceOfDays = DateTime.now().month * 100 +
        DateTime.now().day -
        _prefs.getInt(visitedBuilding);
    if (differenceOfDays < 0) {
      differenceOfDays += _12months;
    }
    if (differenceOfDays > 31 && differenceOfDays < 91) {
      return false;
    } else if (differenceOfDays >= 0 && differenceOfDays < 22)
      return false;
    else
      return true;
  }
}
