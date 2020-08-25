import 'package:flutter/material.dart';

import 'package:checkin/models/models.dart';
import 'package:checkin/services/services.dart';
import 'package:checkin/frontend/views/front_views.dart';

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [
    CovidView(),
    VisitedView(),
    QRScanView(),
    SuggestionView(),
    FrontInfoView(),
  ];
  int currentIndex = 0;

  bool isVisited = false;
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
    currentIndex = index;
    setBusy(false);
  }

  void enterLog(String buildingName) {
    setBusy(true);
    for (var building in buildings) {
      if (building.name == buildingName) {
        if (_logs == null) {
          _logs = [];
        }
        _firestoreService.visitedBuildings(buildingName);
        _firestoreService.updateLogs(Log(
            userName: currentUser.fullName,
            buildingName: buildingName,
            phoneNumber: currentUser.phoneNumber,
            time: DateTime.now().toString().substring(0, 19)));
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
      }

      setBusy(false);
    });
  }
}
