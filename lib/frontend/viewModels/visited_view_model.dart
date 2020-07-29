import 'dart:ffi';

import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../services/firestore_service.dart';

class VisitedViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  SharedPreferences _prefs;
  List<String> visitedBuildings = [];
  String lastStop = "";
  int isToday;
  init() async {
    setBusy(true);
    _prefs = await SharedPreferences.getInstance();
    if (lastStop == "") lastStop = _prefs.getString("last");
    if (_prefs.getInt("today") == DateTime.now().day) {
      visitedBuildings = _prefs.getStringList("buildings");
      updateBuilding();
    } else {
      _prefs.setInt("today", DateTime.now().day);
      _prefs.setStringList("buildings", []);
    }
    setBusy(false);
  }

  void updateBuilding() {
    if (_firestoreService.visitedBuildingNames != null) {
      if (_firestoreService.visitedBuildingNames.isNotEmpty) {
        for (var i in _firestoreService.visitedBuildingNames) {
          if (!visitedBuildings.contains(i)) visitedBuildings.add(i);
        }
        lastStop = _firestoreService.visitedBuildingNames[
            _firestoreService.visitedBuildingNames.length - 1];
        _prefs.setString("last", lastStop);
        _prefs.setStringList("buildings", visitedBuildings);
        _firestoreService.visitedBuildingNames.clear();
      }
    }
  }
}
