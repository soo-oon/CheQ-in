import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';

import 'package:checkin/locator.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:flutter/material.dart';
import '../../backend/viewModels/base_model.dart';

class QrReadViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  init() {
    fetchBuildings();
  }

  void enterLog(String buildingName) {
    if (buildings.contains(buildingName)) {
      for (var building in buildings) {
        if (building.name == buildingName) {
          building.logs.add(Log(currentUser, DateTime.now()));
          _firestoreService.updateBuilding(building);
        }
      }
    }
  }

  Future addBuilding({@required Building building}) async {
    setBusy(true);
    var result = await _firestoreService
        .addBuilding(building); // We need to add the current userId
    setBusy(false);
  }

  void fetchBuildings() async {
    _buildings = await _firestoreService.getBuildings();
  }

  FirestoreService getFirestoreService() {
    return _firestoreService;
  }
}
