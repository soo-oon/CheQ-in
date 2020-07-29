import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/frontend/views/building_view.dart';
import 'package:checkin/frontend/views/front_info_view.dart';
import 'package:checkin/frontend/views/suggestion_view.dart';
import 'package:checkin/frontend/views/visited_view.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../locator.dart';

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [
    BuildingView(),
    VisitedView(),
    SizedBox(),
    SuggestionView(),
    FrontInfoView()
  ];
  int currentIndex = 0;

  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  var _logs;

  init() async {
    setBusy(true);
    _buildings = await _firestoreService.getBuildings();
    _logs = _firestoreService.getLogs();
    setBusy(false);
  }

  void setIndex(int index) {
    setBusy(true);

    if (index == 2) {
      _enterBuilding();
    } else {
      currentIndex = index;
    }
    setBusy(false);
  }

  void _enterBuilding() async {
    // scan the QR of building
    String scannedBuilding = await scanner.scan();

    enterLog(scannedBuilding);
  }

  void enterLog(String buildingName) {
    setBusy(true);
    for (var building in buildings) {
      if (building.name == buildingName) {
        if (_logs == null) {
          _logs = [];
        }
        _firestoreService.visitedBuildings(buildingName);
        _logs.add(Log(
            userName: currentUser.fullName,
            buildingName: buildingName,
            time: DateTime.now().toString()));
        _firestoreService.updateBuilding(building);
      }
    }
    setBusy(false);
  }

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToBuildingsRealTime().listen((postsData) {
      List<Building> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _buildings = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }
}
